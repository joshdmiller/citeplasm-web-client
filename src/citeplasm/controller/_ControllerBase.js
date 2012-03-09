
define(["dojo/_base/declare", "dojo/_base/connect"], function(declare, connect) {
  return declare("citeplasm/controller/_ControllerBase", null, {
    baseTitle: null,
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
    doAction: function(actionName, params) {
      actionName = actionName + "Action";
      if (!this[actionName] || typeof this[actionName] !== "function") {
        throw "The action " + actionName + " does not exist";
      }
      return this[actionName](params);
    }
  });
});
