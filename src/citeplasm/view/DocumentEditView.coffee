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
# citeplasm/view/DocumentEditView is a view representing the viewing of a
# particular document.

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "dijit/_WidgetBase",
    "dijit/_WidgetsInTemplateMixin",
    "dijit/_TemplatedMixin",
    "dojo/text!./templates/DocumentEditView.html",
    "dijit/registry",
    "citeplasm/widget/Editor"
], (declare, _WidgetBase, _WidgetsInTemplateMixin, _TemplatedMixin, template, registry) ->

    # ## citeplasm/view/DocumentEditView
    #
    # citeplasm/view/DocumentEditView is defined using Dojo's declare, based on dijit's
    # _WidgetBase and _Templated.
    declare "citeplasm/view/DocumentEditView", [_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin],

        # The templateString is used by _TemplatedMixin to create a widget
        # based on an HTML template. In this case, we are passing the raw
        # contents of 'templates/Interface.html'.
        templateString: template

        # The baseClass is a CSS class applied to the root element of the
        # template.
        baseClass: "citeplasmDocumentEditView"

        _documentEditor: () ->
            if @de? then @de else @de = registry.byId(this.id + "-documentEditor")

        setBody: (body) ->
            @_documentEditor().set("value", body)

