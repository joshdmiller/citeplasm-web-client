
define(["dojo/_base/declare", "citeplasm/controller/_ControllerBase", "citeplasm/view/DocumentShowView", "citeplasm/model/DocumentStore"], function(declare, _ControllerBase, DocumentShowView, DocumentStore) {
  return declare("citeplasm/controller/DocumentController", _ControllerBase, {
    pre: function() {
      this.doc = DocumentStore.get(this.params.id);
      if (this.doc != null) return this.baseTitle = this.doc.title;
    },
    viewAction: function() {
      var view;
      this.setTitle();
      view = new DocumentShowView();
      this.setView(view);
      this.setBreadcrumb({
        crumbs: [
          {
            name: "Your Documents",
            url: "#/documents"
          }, {
            name: this.baseTitle
          }
        ]
      });
      view.setBody(this.doc.body);
      view.setTitle(this.doc.title);
      view.setAuthor(this.doc.author.uid, this.doc.author.name);
      return view.setAbstract(this.doc.abstract);
    },
    editAction: function() {
      this.setTitle("Editing");
      return this.setBreadcrumb({
        crumbs: [
          {
            name: "Your Documents",
            url: "#/documents"
          }, {
            name: this.baseTitle,
            url: "#/documents/" + this.doc.id
          }, {
            name: "Editing"
          }
        ]
      });
    }
  });
});
