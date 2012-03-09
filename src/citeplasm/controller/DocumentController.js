
define(["dojo/_base/declare", "citeplasm/controller/_ControllerBase"], function(declare, _ControllerBase) {
  return declare("citeplasm/controller/DocumentController", _ControllerBase, {
    baseTitle: "This is My Document Title",
    viewAction: function(params) {
      return this.setTitle();
    },
    editAction: function(params) {
      return this.setTitle("Editing");
    }
  });
});
