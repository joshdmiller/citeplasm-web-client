
define(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_TemplatedMixin", "dojo/text!./templates/Scene.html", "dojo/_base/connect", "dojo/dom-construct", "dojo/_base/array", "dojo/_base/lang"], function(declare, _WidgetBase, _TemplatedMixin, template, connect, domConstruct, array, lang) {
  return declare("citeplasm/Scene", [_WidgetBase, _TemplatedMixin], {
    templateString: template,
    baseClass: "citeplasm",
    _defaultBreadcrumb: {
      crumbs: [
        {
          name: "Citeplasm"
        }
      ]
    },
    _breadcrumbActiveTemplate: "<li class='active'>{name}</li>",
    _breadcrumbTemplate: "<li><a href='{url}'>{name}</a> <span class='divider'>&raquo;</span></li>",
    postCreate: function() {
      return connect.subscribe("/citeplasm/scene/updateBreadcrumb", this, this._updateBreadcrumb);
    },
    _updateBreadcrumb: function(obj) {
      if (!(obj != null)) {
        console.warn("citeplasm/Scene::_updateBreadcrumb | No breadcrumb was provided, setting to default.");
        obj = this._defaultBreadcrumb;
      }
      if (!(obj.crumbs != null) || !(obj.crumbs instanceof Array)) {
        console.error("citeplasm/Scene::_updateBreadcrumb | The object provided to breadcrumb was invalid.");
        obj = this._defaultBreadcrumb;
      }
      domConstruct.empty(this.breadcrumbListNode);
      return dojo.forEach(obj.crumbs, function(crumb) {
        if (!crumb.name) {
          console.error("citeplasm/Scene::_updateBreadcrumb | The breadcrumb is not valid: ", crumb);
          return;
        }
        if (crumb.url != null) {
          return domConstruct.place(lang.replace(this._breadcrumbTemplate, crumb), this.breadcrumbListNode);
        } else {
          return domConstruct.place(lang.replace(this._breadcrumbActiveTemplate, crumb), this.breadcrumbListNode);
        }
      }, this);
    }
  });
});
