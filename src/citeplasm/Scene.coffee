# ## License

# This file is part of the Citeplasm Web Client.
# 
# The Citeplasm Web Client is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your option)
# any later version.
# 
# The Citeplasm Web Client is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
# 
# You should have received a copy of the GNU General Public License along with
# The Citeplasm Web Client.  If not, see <http://www.gnu.org/licenses/>.

# ## Summary

#
# citeplasm/Interface is a widget that encompasses the entire Citeplasm Web
# Client interface. It is the parent widget of all other widgets.

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "dijit/_WidgetBase",
    "dijit/_TemplatedMixin",
    "dojo/text!./templates/Scene.html",
    "dojo/_base/connect",
    "dojo/dom-construct", # place and empty
    "dojo/_base/array", # forEach
    "dojo/_base/lang" # replace
], (declare, _WidgetBase, _TemplatedMixin, template, connect, domConstruct, array, lang) ->

    # ## citeplasm/Interface
    #
    # citeplasm/Interface is defined using Dojo's declare, based on dijit's
    # _WidgetBase and _TemplatedMixin.
    declare "citeplasm/Scene", [_WidgetBase, _TemplatedMixin],

        # The templateString is used by _TemplatedMixin to create a widget
        # based on an HTML template. In this case, we are passing the raw
        # contents of 'templates/Interface.html'.
        templateString: template

        # The baseClass is a CSS class applied to the root element of the
        # template.
        baseClass: "citeplasm"

        # _defaultBreadcrumb is the breadcrumb to use when no breadcrumb or an
        # invalid breadcrumb is passed to the _updateBreadcrumb method.
        _defaultBreadcrumb:
            crumbs: [ { name: "Citeplasm" } ]

        # _breadcrumbActiveTemplate is a string template to use for the
        # generation of the currently-active crumb in the trail.
        _breadcrumbActiveTemplate: "<li class='active'>{name}</li>"

        # _breadcrumbTemplate is a string template to use for the generation of
        # the non-active crumbs in the trail.
        _breadcrumbTemplate: "<li><a href='{url}'>{name}</a> <span class='divider'>&raquo;</span></li>"

        # _toolbarButtonTemplate is a string template to use for the generation
        # of toolbar buttons.
        _toolbarButtonTemplate: "<li><a class='btn'>{name}</a></li>"

        _toolbarMenuTemplate: '<li><div class="btn-group">
            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                {name}
                <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
                {buttons}
            </ul>
            </div></li>'

        _toolbarIconMenuTemplate: '<li>
            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                <i class="{iconClass}"></i>{name} <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
                {buttons}
            </ul>
            </li>'

        # _toolbarIconButtonTemplate is a string template to use for the generation
        # of toolbar buttons with icons.
        _toolbarIconButtonTemplate: "<li><a class='btn'><i class='{iconClass}'></i>{name}</a></li>"

        # ### postCreate does last-minute setup now that the widget has been
        # created. It has not yet been added to the page.
        postCreate: () ->
            connect.subscribe "/citeplasm/scene/updateBreadcrumb", @, @_updateBreadcrumb
            connect.subscribe "/citeplasm/scene/updateToolbar", @, @_updateToolbar

        _generateButton: (tool) ->
            if !tool.iconClass
                return lang.replace @_toolbarButtonTemplate, tool
            else
                return lang.replace @_toolbarIconButtonTemplate, tool

        # ### _updateToolbar
        #
        # _updateToolbar replaces the current toolbar with the provided one. A
        # Toolbar object should look like this:
        #
        #   {
        #       tools: [
        #           item1, item2, item3, ...
        #       ]
        #   }
        #
        # Each item should take this form:
        #
        #   {
        #       type: "button",
        #       name: "My Button",
        #       iconClass: "icon-button"
        #   }
        #
        # Acceptable item types are "button" and "menu". The "menu" type
        # accepts an additional array of button objects called "children".
        _updateToolbar: (obj) ->
            console.log "adding toolbar"
            # We must empty the current toolbar list before adding a new one.
            domConstruct.empty @toolbarListNode
            
            # Now we must ensure both that an object was provided and that it
            # conforms to the expected format. If it was not provided or if it
            # was invalid we log an error return.
            if not obj?
                console.warn "citeplasm/Scene::_updateToolbar | No toolbar was provided, setting to default."
                return
            if not obj.tools? or obj.tools not instanceof Array
                console.error "citeplasm/Scene::_updateToolbar | The toolbar object provided was invalid."
                return

            dojo.forEach obj.tools, (tool) ->
                console.log "Adding tool", tool

                if !tool.type or tool.type not in ["button", "menu"]
                    console.log "citeplasm/Scene::_updateToolbar | Invalid toolbar object type: #{tool.type}."
                    return

                if !tool.name
                    console.log "citeplasm/Scene::_updateToolbar | Button text is required."
                    return

                if tool.type is "button"
                    domConstruct.place @_generateButton(tool), @toolbarListNode
                else
                    if not tool.children? or tool.children not instanceof Array
                        console.error "citeplasm/Scene::_updateToolbar | The menu must have an array of children."
                        return

                    renderedChildren = ""
                    dojo.forEach tool.children, (item) ->
                        if !item.type or item.type not in ["button"]
                            console.log "citeplasm/Scene::_updateToolbar | Invalid toolbar object type in menu: #{item.type}."
                            return
                        if !item.name
                            console.log "citeplasm/Scene::_updateToolbar | Button text is required."
                            return

                        renderedChildren += @_generateButton item
                    , @

                    tool.buttons = renderedChildren
                    if !tool.iconClass
                        domConstruct.place lang.replace(@_toolbarMenuTemplate, tool), @toolbarListNode
                    else
                        domConstruct.place lang.replace(@_toolbarIconMenuTemplate, tool), @toolbarListNode
            , @

        # ### _updateBreadcrumb
        #
        # _updateBreadcrumb replaces the current breadcrumb trail with the
        # provided one. Breadcrumb objects look like the following:
        #
        #   {
        #       crumbs: [
        #           { name: "First", url: "#first" },
        #           { name: "Second", url: "#second" },
        #           { name: "Third" }
        #       ]
        #   }
        _updateBreadcrumb: (obj) ->
            # First we must ensure both that an object was provided and that it
            # conforms to the expected format. If it was not provided, we use
            # the default. If it was invalid we log an error and use the
            # default.
            if not obj?
                console.warn "citeplasm/Scene::_updateBreadcrumb | No breadcrumb was provided, setting to default."
                obj = @_defaultBreadcrumb
            if not obj.crumbs? or obj.crumbs not instanceof Array
                console.error "citeplasm/Scene::_updateBreadcrumb | The object provided to breadcrumb was invalid."
                obj = @_defaultBreadcrumb

            # We must empty the current breadcrumb list before adding a new one.
            domConstruct.empty @breadcrumbListNode

            # For each crumb in obj.crumbs, check if the crumb has at least a
            # name; if it does not, log an error and skip the crumb. If the
            # crumb has a url, we provide an LI with an A and a separator.
            # Otherwise, we just use an LI. The dom node(s) are added to the
            # widget at the @breadcrumbList attach point.
            dojo.forEach obj.crumbs, (crumb) ->
                if !crumb.name
                    console.error "citeplasm/Scene::_updateBreadcrumb | The breadcrumb is not valid: ", crumb
                    return
                
                if crumb.url?
                    domConstruct.place lang.replace(@_breadcrumbTemplate, crumb), @breadcrumbListNode
                else
                    domConstruct.place lang.replace(@_breadcrumbActiveTemplate, crumb), @breadcrumbListNode
            , @

