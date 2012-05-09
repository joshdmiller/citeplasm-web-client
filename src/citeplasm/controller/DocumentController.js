
define(["dojo/_base/declare", "citeplasm/controller/_ControllerBase", "citeplasm/view/DocumentShowView", "citeplasm/view/DocumentEditView", "citeplasm/model/DocumentStore", "dojo/query", "dojo/window", "dojo/on", "dojo/dom-style"], function(declare, _ControllerBase, DocumentShowView, DocumentEditView, DocumentStore, $, win, connectOn, domStyle) {
  return declare("citeplasm/controller/DocumentController", _ControllerBase, {
    pre: function() {
      if (this.params.id != null) {
        this.doc = DocumentStore.get(this.params.id);
        if (this.doc != null) return this.baseTitle = this.doc.title;
      }
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
            url: "#/browser"
          }, {
            name: this.baseTitle
          }
        ]
      });
    },
    editAction: function() {
      var resizeEditor, view;
      this.setTitle("Editing");
      view = new DocumentEditView({
        docBody: this.doc.body,
        docId: this.doc.id
      });
      this.setView(view);
      this.setBreadcrumb({
        crumbs: [
          {
            name: "Your Documents",
            url: "#/browser"
          }, {
            name: this.baseTitle,
            url: "#/documents/" + this.doc.id
          }, {
            name: "Editing"
          }
        ]
      });
      resizeEditor = function() {
        return $(".dijitEditorIFrameContainer, iframe", dojo.byId(view.id + "-documentEditor")).forEach(function(el) {
          var height, winHeight;
          winHeight = win.getBox().h;
          height = winHeight - 159;
          return domStyle.set(el, "height", height + "px");
        });
      };
      connectOn(window, "resize", resizeEditor);
      return resizeEditor();
    }
  });
});
