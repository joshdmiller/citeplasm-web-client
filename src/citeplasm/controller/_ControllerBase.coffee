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
# citeplasm/controller/_ControllerBase is the base class from which all
# application controllers should inherit. It is not meant to be instantiated.

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "dojo/_base/lang",
    "dojo/_base/connect"
], (declare, lang, connect) ->

    # ## citeplasm/controller/_ControllerBase
    declare "citeplasm/controller/_ControllerBase", null,
        # ### Member Variables

        # baseTitle is the suffix for all titles set in the controller.
        baseTitle: null

        # viewNode is the DOM node into which child controllers can place their
        # view.
        viewNode: null

        # currentView is a reference to the currently-visible view widget.
        _currentView: null

        # ### Internal Methods

        # ### Constructor
        #
        # Creates a new insance of the class or its children, incorporating any
        # keyword arguments passed.
        constructor: (kwArgs) ->
            lang.mixin(@, kwArgs)

        # ### Methods for Children to Override

        # #### _tearDown
        #
        # _tearDown is a method for handling controller-specific clean up like
        # widget removal. The view, if it exsts, will be destroyed by @destory,
        # which calls this method, so this need not be done twice. In
        # _ControllerBase, this is only a placeholder.
        _tearDown: () ->
            return

        # ### Methods for Use in Children

        # #### setTitle
        #
        # This is a convenience method for publishing an event to change the
        # title of the current scene. The Application controller receives these
        # signals and changes the window title.
        setTitle: (title) ->
            if @baseTitle?
                if title?
                    title = "#{title} | #{@baseTitle}"
                else
                    title = @baseTitle
            else
                title ?= ""

            connect.publish "/citeplasm/scenetitle", title

        # ### setView
        #
        # setView is an abstraction method for child controllers to add a view
        # element to the page in the appropriate place for the current scene.
        # setView expects a view widget instance to be passed.
        setView: (view) ->
            if !@viewNode then throw "citeplasm/_ControllerBase::setView| No node was provided in which to place views."

            @_currentView = view

            # TODO add error checking here
            @_currentView.placeAt @viewNode

            view.startup()

        # ### setBreadcrumb
        #
        # setBreadcrumb takes a breadcrumb object and publishes it to the
        # appropriate channel.
        setBreadcrumb: (obj) ->
            connect.publish "/citeplasm/scene/updateBreadcrumb", obj

        # ### setToolbar
        #
        # setToolbar takes a toolbar object and publishes it to the appropriate
        # channel, which should be added to the scene's toolbar.
        setToolbar: (obj) ->
            connect.publish "/citeplasm/scene/updateToolbar", obj

        # ## Methods for Use by Application

        # ### destroy
        #
        # destroy tears down the controller. Child classes should override
        # @tearDown to do their custom clean up. @destroy calls
        # destroyRecursive on the view widget if it has been defined.
        destroy: () ->
            @destroyView()
            @setBreadcrumb()
            @setToolbar()
            @_tearDown()

        # ### destroyView
        #
        # destroyView is apropos. The method simply destroys the current view
        # widget if it exists.
        destroyView: () ->
            @_currentView.destroyRecursive() if @_currentView

        # ### doAction
        #
        # doAction is called by citeplasm/Application when executing a
        # particular route. When a child class's doAction is passed the name of
        # an action, it looks for a method with that name suffixed with
        # "Action". For example, if passed "view", it looks for the method
        # @viewAction.
        #
        # If the method exists, it is called with the passed parsed
        # query and url parameters.
        doAction: (actionName, params) ->
            actionName = actionName + "Action"
            if !@[actionName] or typeof(@[actionName]) isnt "function"
                throw "The action #{actionName} does not exist"

            @params = params

            # Controllers can optionally define a @pre method to be invoked
            # before all controller actions are executed. If one has been
            # defined, execute it now.
            if @pre and typeof(@pre) is "function"
                @pre()
            
            # Finally, call the action specified.
            @[actionName]()

