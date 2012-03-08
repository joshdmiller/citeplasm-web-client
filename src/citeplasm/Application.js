
define(["dojo/_base/declare", "citeplasm/Interface", "dojo/_base/window"], function(declare, Interface, win) {
  return declare("citeplasm/Application", null, {
    _interface: null,
    constructor: function() {
      return this._initUi(win.body());
    },
    _initUi: function(container) {
      this._interface = new Interface();
      this._interface.placeAt(container);
      return this._interface.startup();
    }
  });
});
