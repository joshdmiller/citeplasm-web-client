
define(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_TemplatedMixin", "dojo/text!./templates/Scene.html"], function(declare, _WidgetBase, _TemplatedMixin, template) {
  return declare("citeplasm/Scene", [_WidgetBase, _TemplatedMixin], {
    templateString: template,
    baseClass: "citeplasm"
  });
});
