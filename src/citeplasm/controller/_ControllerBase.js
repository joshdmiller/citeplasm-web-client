
define(["dojo/_base/declare", "dojo/_base/lang", "dojo/_base/connect"], function(declare, lang, connect) {
  return declare("citeplasm/controller/_ControllerBase", null, {
    baseTitle: null,
    viewNode: null,
    _currentView: null,
    constructor: function(kwArgs) {
      return lang.mixin(this, kwArgs);
    },
    _tearDown: function() {},
    setTitle: function(title) {
      if (this.baseTitle != null) {
        if (title != null) {
          title = "" + title + " | " + this.baseTitle;
        } else {
          title = this.baseTitle;
        }
      } else {
        if (title == null) title = "";
      }
      return connect.publish("/citeplasm/scenetitle", title);
    },
    setView: function(view) {
      if (!this.viewNode) {
        throw "citeplasm/_ControllerBase::setView| No node was provided in which to place views.";
      }
      this._currentView = view;
      return this._currentView.placeAt(this.viewNode);
    },
    destroy: function() {
      this.destroyView();
      return this._tearDown();
    },
    destroyView: function() {
      if (this._currentView) return this._currentView.destroyRecursive();
    },
    doAction: function(actionName, params) {
      actionName = actionName + "Action";
      if (!this[actionName] || typeof this[actionName] !== "function") {
        throw "The action " + actionName + " does not exist";
      }
      return this[actionName](params);
    }
  });
});
