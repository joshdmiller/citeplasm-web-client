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
# citeplasm/Application provides the application logic for the Citeplasm Web App.

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "dojo/_base/window",
    "dojo/_base/lang",
    "dojo/_base/connect",
    "citeplasm/Scene",
    "citeplasm/Router",
    "citeplasm/controller/DocumentController"
], (declare, win, lang, connect, Scene, Router, DocumentController) ->

    # ## citeplasm/Application
    declare "citeplasm/Application", null,
        # ### Member Variables

        # _scene is a reference to the citeplasm/Scene widget.
        _scene: null

        # _router is the application's routing engine, an instance of citeplasm/Router.
        _router: null

        # _currentController is the application's currently active controller.

        # ### constructor
        #
        # The constructor instantiates Application, but also adds
        # citeplasm/Scene to the document body.
        constructor: () ->

            # Listen for events published to /citeplasm/scenetitle and run the
            # changeTitle method.
            connect.subscribe "/citeplasm/scenetitle", @changeTitle
            
            @_initUi win.body()
            @_initRouting()

            @_startup()

        # ### _initRouting
        #
        # _initRouting is an internal method for configuring the routing engine.
        _initRouting: () ->
            @_router = new Router [
                    path: "/dashboard"
                    defaultRoute: true
                    handler: lang.hitch(@, (params, route) ->
                        @changeTitle "Dashboard"
                    )
                ,
                    path: "/resources"
                    handler: lang.hitch(@, (params, route) ->
                        @changeTitle "Resources"
                    )
                ,
                    path: "/documents/:id"
                    handler: @_connectController(DocumentController, "view")
                ,
                    path: "/documents/:id/edit"
                    handler: @_connectController(DocumentController, "edit")
            ]

        # ### _initUi
        #
        # _initUi instantiates the citeplasm/Scene into the provided dom
        # object and initializes its state.
        _initUi: (container) ->
            @_scene = new Scene()
            @_scene.placeAt(container)
            @_scene.startup()

        # ### changeTitle
        #
        # changeTitle quite simply changes the title of the current page to the
        # specified title with the suffix " | my.citeplasm.com".
        changeTitle: (title) ->
            win.doc.title = title + " | my.citeplasm.com"

        # ### _startup
        #
        # This function readies the application for user interaction.
        _startup: () ->
            @_router.init()

        # ### _connectController
        #
        # This internal method returns a function for use as a route handler in
        # the Router. The function destroys the existing active controller, if
        # any, instantiates the provided controller, and executes the view
        # specified.
        _connectController: (controller, action) ->
            (params, route) ->
                # First we must destroy the existing controller, should it exist.
                @_currentController.destroy() if @_currentController && !@_currentController.isInstanceOf controller

                # Next, we instantiate the provided controller.
                @_currentController = new controller()

                # Finally, we execute the action of the instantiated controller.
                @_currentController.doAction action, params

