(function() {

  define(["dojo/_base/declare", "dijit/Editor"], function(declare, Editor) {
    return declare("citeplasm/widget/Editor", [Editor], {
      baseClass: "citeplasmEditor"
    });
  });

}).call(this);
