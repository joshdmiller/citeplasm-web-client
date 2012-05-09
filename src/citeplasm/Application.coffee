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
# citeplasm/Application provides the application logic for the Citeplasm Web App
# and powers the Citeplasm MVC architecture.

# ## MVC Framework
#
# ### Routing
#
# citeplasm/Application registers a set of routes with an instance of
# citeplasm/Router, which monitors for hash changes and calls the matching
# registered route's function handler. The function handler is generated by
# Appplication._connectController based on the controller class and action name
# provided. When executed by the router in response to a hash change event, the
# generated function instantiates the controller and runs the specified action.
#
# ### Controllers
#
# The application glues a requested route and the data model to the scene
# through the use of a controller. The controller interacts with the data
# stores, renders the correct view widget to the scene, and handles all
# interaction between the application, the data model, and the view. An example
# controller is citeplasm/view/DocumentController.
#
# ### Views
#
# A view is a widget that gets rendered on a page by a controller action. In
# most cases, it will have child widgets. An example view is
# citeplasm/view/DocumentShowView which is responsible for rendering a widget
# to display a document.
#
# ### Scene
#
# The scene represents the overall client-side webpage. A separate scene for
# desktop and mobile will eventually be provided. A view is placed within a scene.
# The only current example is citeplasm/Scene.
#
# ### Models
#
# Models are not yet implemented.
#

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "dojo/_base/window",
    "dojo/_base/lang",
    "dojo/_base/connect",
    "citeplasm/Scene",
    "citeplasm/Router",
    "citeplasm/controller/DocumentController",
    "citeplasm/controller/BrowserController"
], (declare, win, lang, connect, Scene, Router, DocumentController, BrowserController) ->

    # ## citeplasm/Application
    declare "citeplasm/Application", null,
        # ### Member Variables

        # _scene is a reference to the citeplasm/Scene widget.
        _scene: null

        # _router is the application's routing engine, an instance of citeplasm/Router.
        _router: null

        # _currentController is the application's currently active controller.
        _currentController: null

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
                    path: "/browser"
                    handler: lang.hitch @, @_connectController(BrowserController, "list")
                ,
                    path: "/documents/:id"
                    handler: lang.hitch(@, @_connectController(DocumentController, "view"))
                ,
                    path: "/documents/:id/edit"
                    handler: lang.hitch(@, @_connectController(DocumentController, "edit"))
            ]

        # ### _initUi
        #
        # _initUi instantiates the citeplasm/Scene into the provided dom
        # object and initializes its state. Future iterations of this class
        # will allow the selection of a mobile scene and a desktop scene,
        # depending on the client browser. For now it is statically set to the
        # desktop scene.
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
                # If a controller has already been instantiated, we need to do
                # some cleanup before overwriting it. If the controller is an
                # instance of the controller we are going to create anyway, we
                # only need to destroy the view through
                # _ControllerBase.destroyView. Otherwise, we call destroy on
                # the whole controller, which should clean up any
                # subscriptions, data stores, and other resources it owns in
                # addition to destroying the view.
                if @_currentController
                    if @_currentController.isInstanceOf controller
                        @_currentController.destroyView()
                    else
                        @_currentController.destroy()

                # Next, we instantiate the provided controller.
                viewNode = @_scene.viewNode
                @_currentController = new controller(
                    viewNode: @_scene.viewNode
                )

                # Finally, we execute the action of the instantiated controller.
                @_currentController.doAction action, params

