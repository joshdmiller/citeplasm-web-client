
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
    _toolbarButtonTemplate: "<li><a class='btn'>{name}</a></li>",
    _toolbarMenuTemplate: '<li><div class="btn-group">\
            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">\
                {name}\
                <span class="caret"></span>\
            </a>\
            <ul class="dropdown-menu">\
                {buttons}\
            </ul>\
            </div></li>',
    _toolbarIconMenuTemplate: '<li>\
            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">\
                <i class="{iconClass}"></i>{name} <span class="caret"></span>\
            </a>\
            <ul class="dropdown-menu">\
                {buttons}\
            </ul>\
            </li>',
    _toolbarIconButtonTemplate: "<li><a class='btn'><i class='{iconClass}'></i>{name}</a></li>",
    postCreate: function() {
      connect.subscribe("/citeplasm/scene/updateBreadcrumb", this, this._updateBreadcrumb);
      return connect.subscribe("/citeplasm/scene/updateToolbar", this, this._updateToolbar);
    },
    _generateButton: function(tool) {
      if (!tool.iconClass) {
        return lang.replace(this._toolbarButtonTemplate, tool);
      } else {
        return lang.replace(this._toolbarIconButtonTemplate, tool);
      }
    },
    _updateToolbar: function(obj) {
      console.log("adding toolbar");
      domConstruct.empty(this.toolbarListNode);
      if (!(obj != null)) {
        console.warn("citeplasm/Scene::_updateToolbar | No toolbar was provided, setting to default.");
        return;
      }
      if (!(obj.tools != null) || !(obj.tools instanceof Array)) {
        console.error("citeplasm/Scene::_updateToolbar | The toolbar object provided was invalid.");
        return;
      }
      return dojo.forEach(obj.tools, function(tool) {
        var renderedChildren, _ref;
        console.log("Adding tool", tool);
        if (!tool.type || ((_ref = tool.type) !== "button" && _ref !== "menu")) {
          console.log("citeplasm/Scene::_updateToolbar | Invalid toolbar object type: " + tool.type + ".");
          return;
        }
        if (!tool.name) {
          console.log("citeplasm/Scene::_updateToolbar | Button text is required.");
          return;
        }
        if (tool.type === "button") {
          return domConstruct.place(this._generateButton(tool), this.toolbarListNode);
        } else {
          if (!(tool.children != null) || !(tool.children instanceof Array)) {
            console.error("citeplasm/Scene::_updateToolbar | The menu must have an array of children.");
            return;
          }
          renderedChildren = "";
          dojo.forEach(tool.children, function(item) {
            var _ref2;
            if (!item.type || ((_ref2 = item.type) !== "button")) {
              console.log("citeplasm/Scene::_updateToolbar | Invalid toolbar object type in menu: " + item.type + ".");
              return;
            }
            if (!item.name) {
              console.log("citeplasm/Scene::_updateToolbar | Button text is required.");
              return;
            }
            return renderedChildren += this._generateButton(item);
          }, this);
          tool.buttons = renderedChildren;
          if (!tool.iconClass) {
            return domConstruct.place(lang.replace(this._toolbarMenuTemplate, tool), this.toolbarListNode);
          } else {
            return domConstruct.place(lang.replace(this._toolbarIconMenuTemplate, tool), this.toolbarListNode);
          }
        }
      }, this);
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
