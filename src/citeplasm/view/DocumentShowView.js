(function() {

  define(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_WidgetsInTemplateMixin", "dijit/_TemplatedMixin", "dojo/text!./templates/DocumentShowView.html"], function(declare, _WidgetBase, _WidgetsInTemplateMixin, _TemplatedMixin, template, registry) {
    return declare("citeplasm/view/DocumentShowView", [_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin], {
      templateString: template,
      baseClass: "citeplasmDocument",
      postCreate: function() {
        this.containerNode.innerHTML = this.docBody;
        this.titleNode.innerHTML = this.docTitle;
        this.authorNode.innerHTML = "by <a href='#/authors/" + this.docAutorId + "'>" + this.docAuthorName + "</a>";
        return this.abstractNode.innerHTML = "<p>" + this.docAbstract + "</p>";
      }
    });
  });

}).call(this);
