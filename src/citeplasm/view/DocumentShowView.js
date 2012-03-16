
define(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_WidgetsInTemplateMixin", "dijit/_TemplatedMixin", "dojo/text!./templates/DocumentShowView.html", "dijit/registry", "citeplasm/widget/DocumentViewer"], function(declare, _WidgetBase, _WidgetsInTemplateMixin, _TemplatedMixin, template, registry) {
  return declare("citeplasm/view/DocumentShowView", [_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin], {
    templateString: template,
    baseClass: "citeplasmDocumentShowView",
    _documentViewer: function() {
      if (this.dv != null) {
        return this.dv;
      } else {
        return this.dv = registry.byId(this.id + "-documentViewer");
      }
    },
    setBody: function(body) {
      return this._documentViewer().containerNode.innerHTML = body;
    },
    setTitle: function(title) {
      return this._documentViewer().titleNode.innerHTML = title;
    },
    setAuthor: function(id, name) {
      return this._documentViewer().authorNode.innerHTML = "<a href='#/author/" + id + "'>" + name + "</a>";
    },
    setAbstract: function(abstract) {
      return this._documentViewer().abstractNode.innerHTML = "<p>" + abstract + "</p>";
    }
  });
});
