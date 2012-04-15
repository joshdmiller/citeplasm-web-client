(function() {

  define(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_WidgetsInTemplateMixin", "dijit/_TemplatedMixin", "dojo/text!./templates/DocumentEditView.html", "dijit/registry", "citeplasm/widget/Editor"], function(declare, _WidgetBase, _WidgetsInTemplateMixin, _TemplatedMixin, template, registry) {
    return declare("citeplasm/view/DocumentEditView", [_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin], {
      templateString: template,
      baseClass: "citeplasmDocumentEditView",
      _documentEditor: function() {
        if (this.de != null) {
          return this.de;
        } else {
          return this.de = registry.byId(this.id + "-documentEditor");
        }
      },
      setBody: function(body) {
        return this._documentEditor().set("value", body);
      }
    });
  });

}).call(this);
