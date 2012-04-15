(function() {

  define(["dojo/_base/declare", "citeplasm/controller/_ControllerBase", "citeplasm/view/DocumentShowView", "citeplasm/view/DocumentEditView", "citeplasm/model/DocumentStore"], function(declare, _ControllerBase, DocumentShowView, DocumentEditView, DocumentStore) {
    return declare("citeplasm/controller/DocumentController", _ControllerBase, {
      pre: function() {
        this.doc = DocumentStore.get(this.params.id);
        if (this.doc != null) return this.baseTitle = this.doc.title;
      },
      viewAction: function() {
        var view;
        this.setTitle();
        view = new DocumentShowView({
          docId: this.doc.id,
          docBody: this.doc.body,
          docTitle: this.doc.title,
          docAuthorId: this.doc.author.uid,
          docAuthorName: this.doc.author.name,
          docAbstract: this.doc.abstract
        });
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
      editAction: function() {
        var view;
        this.setTitle("Editing");
        view = new DocumentEditView();
        this.setView(view);
        this.setBreadcrumb({
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
        return view.setBody(this.doc.body);
      }
    });
  });

}).call(this);
