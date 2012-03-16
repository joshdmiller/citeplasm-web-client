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
# citeplasm/widget/DocumentViewer is a widget that displays a provided document
# in HTML format with some miscellaneous controls.

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "dijit/_WidgetBase",
    "dijit/_TemplatedMixin",
    "dojo/text!./templates/DocumentViewer.html"
], (declare, _WidgetBase, _TemplatedMixin, template) ->

    # ## citeplasm/widget/DocumentViewer
    #
    # citeplasm/widget/DocumentViewer is defined using Dojo's declare, based on dijit's
    # _WidgetBase and _TemplatedMixin.
    declare "citeplasm/widget/DocumentViewer", [_WidgetBase, _TemplatedMixin],

        # The templateString is used by _TemplatedMixin to create a widget
        # based on an HTML template. In this case, we are passing the raw
        # contents of 'templates/Interface.html'.
        templateString: template

        # The baseClass is a CSS class applied to the root element of the
        # template.
        baseClass: "citeplasmDocumentViewer"

