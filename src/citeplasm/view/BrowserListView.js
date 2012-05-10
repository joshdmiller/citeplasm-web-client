
define(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_WidgetsInTemplateMixin", "dijit/_TemplatedMixin", "dojo/text!./templates/BrowserListView.html", "dojo/dom", "dojo/_base/array", "dojo/dom-construct", "dojo/date", "dojo/date/locale", "dojo/date/stamp", "citeplasm/model/FolderStore", "dijit/tree/ObjectStoreModel", "dijit/Tree"], function(declare, _WidgetBase, _WidgetsInTemplateMixin, _TemplatedMixin, template, dom, array, domConstruct, date, locale, stamp, FolderStore, ObjectStoreModel, Tree) {
  return declare("citeplasm/view/BrowserListView", [_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin], {
    templateString: template,
    baseClass: "citeplasmBrowserList",
    postCreate: function() {
      var tree, treeModel;
      console.log(FolderStore);
      treeModel = new ObjectStoreModel({
        store: FolderStore,
        query: {
          id: 0
        }
      });
      tree = new Tree({
        model: treeModel,
        showRoot: false,
        onClick: function(item) {
          return location.href = "#/browser/folders/" + item.id;
        }
      });
      tree.placeAt(this.folderTree);
      return tree.startup();
    },
    addDocs: function(docs) {
      var tableBody, tbody;
      tableBody = "" + this.id + "-table-body";
      tbody = dom.byId(tableBody);
      return array.forEach(docs, function(doc) {
        var dt, fmt, td_mod, td_title, today, tr, yesterday;
        dt = stamp.fromISOString(doc.modified_at);
        if (doc.type === "d") {
          doc["class"] = "doc";
          doc.url = "documents";
        } else if (doc.type === "r") {
          doc["class"] = "resource";
          doc.url = "resources";
        } else if (doc.type === "n") {
          doc["class"] = "note";
          doc.url = "notes";
        }
        today = new Date();
        yesterday = date.add(today, "day", -1);
        fmt = "";
        console.log("Dt=" + (locale.format(dt)) + "; difference is " + (date.difference(today, dt)));
        if (date.difference(today, dt) === 0) {
          fmt = locale.format(dt, {
            selector: 'time'
          });
        } else if (date.difference(dt, yesterday) === 0) {
          fmt = "Yesterday";
        } else if (dt.getFullYear() === today.getFullYear()) {
          fmt = locale.format(dt, {
            selector: 'date',
            formatLength: 'medium',
            datePattern: 'dd MMM'
          });
        } else {
          fmt = locale.format(dt, {
            selector: 'date',
            formatLength: 'short'
          });
        }
        tr = domConstruct.create("tr", {}, tbody);
        td_title = domConstruct.create("td", {
          innerHTML: "<a href='#/" + doc.url + "/" + doc.id + "'><i class='icon-" + doc["class"] + "'></i>" + doc.title + "</a>"
        }, tr);
        return td_mod = domConstruct.create("td", {
          innerHTML: fmt
        }, tr);
      });
    }
  });
});
