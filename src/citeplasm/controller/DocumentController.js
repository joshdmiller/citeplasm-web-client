
define(["dojo/_base/declare", "citeplasm/controller/_ControllerBase", "citeplasm/view/DocumentShowView"], function(declare, _ControllerBase, DocumentShowView) {
  return declare("citeplasm/controller/DocumentController", _ControllerBase, {
    baseTitle: "This is My Document Title",
    viewAction: function(params) {
      var view;
      this.setTitle();
      view = new DocumentShowView();
      this.setView(view);
      return this.setBreadcrumb({
        crumbs: [
          {
            name: "Your Documents",
            url: "#/documents"
          }, {
            name: this.baseTitle
          }
        ]
      });
    },
    editAction: function(params) {
      this.setTitle("Editing");
      return this.setBreadcrumb({
        crumbs: [
          {
            name: "Your Documents",
            url: "#/documents"
          }, {
            name: this.baseTitle,
            url: "#/documents/1234"
          }, {
            name: "Editing"
          }
        ]
      });
    }
  });
});
