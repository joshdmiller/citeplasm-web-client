
define(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_TemplatedMixin", "dojo/text!./templates/DocumentShowView.html"], function(declare, _WidgetBase, _TemplatedMixin, template) {
  return declare("citeplasm/view/DocumentShowView", [_WidgetBase, _TemplatedMixin], {
    templateString: template,
    baseClass: "citeplasmDocumentShowView"
  });
});
