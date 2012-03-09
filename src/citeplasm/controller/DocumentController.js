
define(["dojo/_base/declare", "citeplasm/controller/_ControllerBase", "citeplasm/view/DocumentShowView"], function(declare, _ControllerBase, DocumentShowView) {
  return declare("citeplasm/controller/DocumentController", _ControllerBase, {
    baseTitle: "This is My Document Title",
    viewAction: function(params) {
      var view;
      this.setTitle();
      view = new DocumentShowView();
      return this.setView(view);
    },
    editAction: function(params) {
      return this.setTitle("Editing");
    }
  });
});
