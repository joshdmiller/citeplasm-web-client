
define(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_TemplatedMixin", "dojo/text!./templates/DocumentViewer.html"], function(declare, _WidgetBase, _TemplatedMixin, template) {
  return declare("citeplasm/widget/DocumentViewer", [_WidgetBase, _TemplatedMixin], {
    templateString: template,
    baseClass: "citeplasmDocumentViewer"
  });
});
