
define(["dojo/_base/declare", "dojo/_base/window", "dojo/_base/lang", "dojo/_base/connect", "citeplasm/Scene", "citeplasm/Router", "citeplasm/controller/DocumentController"], function(declare, win, lang, connect, Scene, Router, DocumentController) {
  return declare("citeplasm/Application", null, {
    _scene: null,
    _router: null,
    constructor: function() {
      connect.subscribe("/citeplasm/scenetitle", this.changeTitle);
      this._initRouting();
      this._initUi(win.body());
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
          path: "/documents/:id",
          handler: this._connectController(DocumentController, "view")
        }, {
          path: "/documents/:id/edit",
          handler: this._connectController(DocumentController, "edit")
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
        if (this._currentController && !this._currentController.isInstanceOf(controller)) {
          this._currentController.destroy();
        }
        this._currentController = new controller();
        return this._currentController.doAction(action, params);
      };
    }
  });
});
