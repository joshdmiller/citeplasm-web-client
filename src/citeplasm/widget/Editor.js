(function() {

  define(["dojo/_base/declare", "dijit/Editor"], function(declare, Editor) {
    return declare("citeplasm/widget/Editor", [Editor], {
      baseClass: "citeplasmEditor",
      constructor: function() {
        this.inherited(arguments);
        return this.addStyleSheet("/app/resources/app.css");
      }
    });
  });

}).call(this);
