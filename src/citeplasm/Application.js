
define(["dojo/_base/declare", "dojo/_base/window", "dojo/_base/lang", "dojo/_base/connect", "citeplasm/Scene", "citeplasm/Router", "citeplasm/controller/DocumentController", "citeplasm/controller/BrowserController"], function(declare, win, lang, connect, Scene, Router, DocumentController, BrowserController) {
  return declare("citeplasm/Application", null, {
    _scene: null,
    _router: null,
    _currentController: null,
    constructor: function() {
      connect.subscribe("/citeplasm/scenetitle", this.changeTitle);
      this._initUi(win.body());
      this._initRouting();
      return this._startup();
    },
    _initRouting: function() {
      return this._router = new Router([
        {
          path: "/dashboard",
          defaultRoute: true,
          handler: lang.hitch(this, function(params, route) {
            return this.changeTitle("Dashboard");
          })
        }, {
          path: "/resources",
          handler: lang.hitch(this, function(params, route) {
            return this.changeTitle("Resources");
          })
        }, {
          path: "/browser",
          handler: lang.hitch(this, this._connectController(BrowserController, "list"))
        }, {
          path: "/documents/:id",
          handler: lang.hitch(this, this._connectController(DocumentController, "view"))
        }, {
          path: "/documents/:id/edit",
          handler: lang.hitch(this, this._connectController(DocumentController, "edit"))
        }
      ]);
    },
    _initUi: function(container) {
      this._scene = new Scene();
      this._scene.placeAt(container);
      return this._scene.startup();
    },
    changeTitle: function(title) {
      return win.doc.title = title + " | my.citeplasm.com";
    },
    _startup: function() {
      return this._router.init();
    },
    _connectController: function(controller, action) {
      return function(params, route) {
        var viewNode;
        if (this._currentController) {
          if (this._currentController.isInstanceOf(controller)) {
            this._currentController.destroyView();
          } else {
            this._currentController.destroy();
          }
        }
        viewNode = this._scene.viewNode;
        this._currentController = new controller({
          viewNode: this._scene.viewNode
        });
        return this._currentController.doAction(action, params);
      };
    }
  });
});
