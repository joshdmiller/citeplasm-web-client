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
# citeplasm/widget/Editor is a rich text editor based on dijit/Editor used for
# editing documents and notes. The output is normalized into a common
# HTML-based format when retrieved.

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "dijit/Editor",
], (declare, Editor) ->

    # ## citeplasm/widget/Editor
    #
    # citeplasm/widget/Editor is defined using Dojo's declare, based on dijit's
    # _WidgetBase and _TemplatedMixin.
    declare "citeplasm/widget/Editor", [Editor],

        # The baseClass is a CSS class applied to the root element of the
        # template.
        baseClass: "citeplasmEditor"

