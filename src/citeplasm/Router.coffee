# ## License

# This file is part of the Citeplasm Web Client.
# 
# The Citeplasm Web Client is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your option)
# any later version.
# 
# The Citeplasm Web Client is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
# 
# You should have received a copy of the GNU General Public License along with
# The Citeplasm Web Client.  If not, see <http://www.gnu.org/licenses/>.

# ## Summary

#
# citeplasm/Router is a dojo/hash-based URL router as part of Citeplasm's MVC
# approach, based on Colin Snover's dbp.Router.
#
# Router allows individual routes to include both query and path string
# parameters which are then available inside the handling function. Here is an
# example of url routes and paths that resolve to them:
#
#     /docs/:id         ->      #/docs/12345
#     /search           ->      #/search?query=polymerase
#
# A route has three components: a regular expression string representing the
# path of the route, a method handler that is invoked each time the route is
# matched, and a boolean value indicating whether this value should be
# considered the default. 
#
# The route handler method is a function that takes two parameters: an object
# containing the parameters pulled from the route path, and an object
# containing information about the route that invoked the method handler.
#
# If no default is specified, the first route provided becomes the default.
#
# Example usage:
#
#     router = new Router [
#             path: "/docs/:id"
#             defaultRoute: true
#             handler: (params, route) ->
#                 console.log "Inside the route"
#         ,
#             path: "/search"
#             defaultRoute: false
#             handler: (params, route) ->
#                 console.log "Inside the route"
#     ]
#

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "dojo/hash",
    "dojo/_base/array",
    "dojo/_base/connect",
    "dojo/_base/lang",
    "dojo/io-query"
], (declare, hash, array, connect, lang, ioquery) ->

    # ## Global Variables
    routes = []
    routeCache = {}
    currentPath = null
    subscriptions = []

    PATH_REPLACER = "([^\/]+)"
    PATH_NAME_MATCHER = /:([\w\d]+)/g

    # ## citeplasm/router
    #
    # citeplasm/Router is defined using Dojo's declare with no superclass.
    declare("citeplasm.Router", null,
        # ### constructor
        #
        # The constructor creates an instance of citeplasm/Router and loads it
        # with the routes provided; if no default was provided, the first route
        # provided becomes the default.
        constructor: (userRoutes) ->
            console.log userRoutes
            if !userRoutes or !userRoutes.length
                throw "No routes provided to citeplasm/Router."

            if routes.length
                console.warn "An instance of citeplasm/Router already exists. Continuing anyway."

            array.forEach userRoutes, (r) ->
                console.log "citeplasm/Router::constructor is registering route '#{r.path}'"
                @_registerRoute r.path, r.handler, r.defaultRoute
            , this

            # if there is no default, use the first as the default
            if !@defaultRoute
                @defaultRoute = userRoutes[0]


            return

        # ### init
        #
        # The init method processes the current hash or, if none exists, uses
        # the default route. Also subscribe to the event 'dojo/hashchange'
        # which is called, appropriately enough, when the URL hash changes,
        # triggering the '_handle' method when published.
        init: () ->
            console.log "citeplasm/Router::init with current hash as " + hash()
            @go hash() or @defaultRoute.path

            subscriptions.push connect.subscribe("/dojo/hashchange", @, () ->
                console.log "citeplasm/Router received /dojo/hashchange with " + hash()
                @_handle hash()
                return
            )

        # ### go
        #
        # The go method redirects to the specified path.
        go: (path) ->
            console.log "citeplasm/Router::go(#{path})"
            path = lang.trim path
            return if !path

            @_handle path

            if path.indexOf("#") isnt 0
                path = "#" + path

            hash(path)

        # ### _handle
        #
        # The _handle method is the internal handler for for all hash changes.
        _handle: (hashValue) ->
            if hashValue is currentPath
                return

            path = hashValue.replace("#", "")
            route = @_chooseRoute @_getRouteablePath(path) or @defaultRoute
            params = @_parseParams path, route

            route = lang.mixin route,
                hash: hashValue
                params: params

            route.handler params, route

        # ### _chooseRoute
        #
        # The _chooseRoute method is the internal means of relating a hash to a
        # route.
        _chooseRoute: (path) ->
            if !routeCache[path]
                routeablePath = @_getRouteablePath path
                array.forEach routes, (r) ->
                    routeCache[path] = r if routeablePath.match r.matcher

            routeCache[path]

        # ### _registerRoute
        #
        # The _registerRoute method internally handles associating a route with
        # this instance of the router. 
        #
        # The first parameter (path) is either a String or Regex that
        # represents pattern of the path to which this route applies.  The
        # second parameter (fx) is a function handler to be executed when the
        # route is run.  The last parameter (defaultRoute) is a Boolean value
        # indicating whether this route shouldbe considered the default.
        _registerRoute: (path, fx, defaultRoute) ->
            r = 
                path: path
                handler: fx
                matcher: @_convertPathToMatcher path
                paramNames: @_getParamNames path

            routes.push r

            @defaultRoute = r if defaultRoute

        # ### _convertPathToMatcher
        #
        # The _convertPathToMatcher method converts a String path to a regex
        # that can be used as a matcher. If a regex is already provided, it is
        # returned without alteration.
        #
        # The route parameter is either a String or a Regex to be converted to a regex.
        #
        # _convertPathToMatcher returns a Regex matcher.
        _convertPathToMatcher: (route) ->
            if lang.isString route
                new RegExp "^" + route.replace(PATH_NAME_MATCHER, PATH_REPLACER) + "$"
            else
                route

        # ### _parseParams
        #
        # The _parseParams method generates an object containing the parameter
        # names and values of the provided hash and route object. The object
        # contains all query object parameters as members and an additional
        # 'splat' member that is an array of route parameters.
        #
        # Given the example route '/doc/:id' and the path
        # '/doc/1234?param1=hello&param2=goodbye', the return object is of the
        # form:
        #     
        #     {
        #         param1: "hello",
        #         param2: "goodbye",
        #         splat: ["1234"]
        #     }
        _parseParams: (hashValue, route) ->
            parts = hashValue.split "?"
            path = parts[0]
            query = parts[1]
            _decode = decodeURIComponent

            # If there indeed are query parameters, we use dojo/io-query's
            # queryToObject to create an object from the query parameters. See
            # http://livedocs.dojotoolkit.org/dojo/queryToObject for more
            # information.
            params = if query then lang.mixin {}, ioquery.queryToObject(query) else {}

            # Now that we have the query parameters, we need to match the
            # route's parameters too. For example, the route matcher '/doc/:id'
            # and the path '/doc/1234' should yield a parameter with a value of
            # '1234'.
            if pathParams = route.matcher.exec @_getRouteablePath(path) isnt null
                # Of course, the first match is the full path so we'll ignore it.
                parseParams.shift()

                # Now we loop through each of the matches in the route. If
                # there is a matching parameter name, we simply add the
                # parameter and its value to the object. Otherwise, we add it
                # to the splat.
                array.forEach pathParams, (param, i) ->
                    if route.paramNames[i]
                        params[route.paramNames[i]] = _decode param
                    else
                        params.splat = [] if !params.splat
                        params.splat.push _decode(param)

            return params

        # ### _getRouteablePath
        #
        # This method removes the query string from the provided path string so
        # it can be used in matching methods.
        _getRouteablePath: (path) ->
            path.split("?")[0]

        # ### _getParamNames
        #
        # This method takes a provided path as either a string or a regex and
        # returns an array of parameter names expected by the route.
        _getParamNames: (path) ->
            paramNames = []

            PATH_NAME_MATCHER.lastIndex = 0

            while pathMatch = PATH_NAME_MATCHER.exec(path) isnt null
                paramNames.push pathMatch[1]

            return paramNames

        # ### destroy
        #
        # When necessary to clean up, destroy all subscriptions.
        destroy: () ->
            array.forEach subscriptions, connect.unsubscribe
    )

