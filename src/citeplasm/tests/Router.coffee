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

define [
    "../Router"
], (Router) ->

    routes = [
            path: "/test/sub"
            handler: () -> return
        ,
            path: "/test"
            handler: () -> return
            defaultRoute: true
    ]
    
    routesWithoutDefault = [
            path: "/test"
            handler: () -> return
        ,
            path: "/test/sub"
            handler: () -> return
    ]

    createRouter = () ->
        @router = new Router routes
    
    doh.register "citeplasm/Router", [
        {
            name: "It should throw an Error if initialized without routes."
            runTest: (t) ->
                try
                    r = new Router()
                catch e
                    t.t e instanceof Error
                    return true

                throw "Did not catch an error!"
        },{
            name: "It should throw an Error if initialized with an empty array."
            runTest: (t) ->
                try
                    r = new Router([])
                catch e
                    t.t e instanceof Error
                    return true

                throw "Did not catch an error!"
        },{
            name: "It should initialize correctly with a set of proper routes."
            setUp: createRouter
            runTest: (t) ->
                t.t @router instanceof Router
        },{
            name: "It should set the default route when provided explicitly."
            setUp: createRouter
            runTest: (t) ->
                t.is @router._defaultRoute.path, routes[1].path
        },{
            name: "It should set the default route to the first route when not provided excplicitly."
            setUp: () -> @router = new Router routesWithoutDefault
            runTest: (t) ->
                t.is @router._defaultRoute.path, routesWithoutDefault[1].path
        }
    ]
