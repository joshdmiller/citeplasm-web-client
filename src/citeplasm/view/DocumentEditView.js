(function() {

  define(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_WidgetsInTemplateMixin", "dijit/_TemplatedMixin", "dojo/text!./templates/DocumentEditView.html", "dijit/registry", "citeplasm/widget/Editor"], function(declare, _WidgetBase, _WidgetsInTemplateMixin, _TemplatedMixin, template, registry) {
    return declare("citeplasm/view/DocumentEditView", [_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin], {
      templateString: template,
      baseClass: "citeplasmDocumentEdit",
      _documentEditor: function() {
        if (this.de != null) {
          return this.de;
        } else {
          return this.de = registry.byId(this.id + "-documentEditor");
        }
      },
      postCreate: function() {
        var ed;
        ed = this._documentEditor();
        return ed.set("value", this.docBody);
      }
    });
  });

}).call(this);
