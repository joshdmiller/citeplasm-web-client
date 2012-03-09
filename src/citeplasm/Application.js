
define(["dojo/_base/declare", "dojo/_base/window", "dojo/_base/lang", "citeplasm/Interface", "citeplasm/Router"], function(declare, win, lang, Interface, Router) {
  return declare("citeplasm/Application", null, {
    _interface: null,
    _router: null,
    constructor: function() {
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
        }
      ]);
    },
    _initUi: function(container) {
      this._interface = new Interface();
      this._interface.placeAt(container);
      return this._interface.startup();
    },
    changeTitle: function(title) {
      return win.doc.title = title + " | my.citeplasm.com";
    },
    _startup: function() {
      return this._router.init();
    }
  });
});
