
define(["dojo/_base/declare", "citeplasm/controller/_ControllerBase", "citeplasm/view/BrowserListView", "citeplasm/model/DocumentStore", "dojo/query", "dojo/window", "dojo/on", "dojo/dom-style"], function(declare, _ControllerBase, BrowserListView, DocumentStore, $, win, connectOn, domStyle) {
  return declare("citeplasm/controller/BrowserController", _ControllerBase, {
    listAction: function() {
      var view;
      this.setTitle("Your Documents");
      view = new BrowserListView();
      this.setBreadcrumb({
        crumbs: [
          {
            name: "Your Documents"
          }
        ]
      });
      this.setToolbar({
        tools: [
          {
            type: "menu",
            name: "Create",
            iconClass: "icon-new",
            children: [
              {
                type: "button",
                name: "Resource",
                iconClass: "icon-new-resource"
              }, {
                type: "button",
                name: "Note",
                iconClass: "icon-new-note"
              }, {
                type: "button",
                name: "Document",
                iconClass: "icon-new-doc"
              }
            ]
          }, {
            type: "button",
            name: "Settings",
            iconClass: "icon-settings"
          }
        ]
      });
      this.setView(view);
      return view.addDocs(DocumentStore.query({}, {
        sort: [
          {
            attribute: 'modified_at',
            descending: true
          }
        ]
      }));
    }
  });
});
