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
# citeplasm/controller/BrowserController is the controller class for the
# document browser functionality.

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "citeplasm/controller/_ControllerBase",
    "citeplasm/view/BrowserListView",
    "citeplasm/model/DocumentStore",
    "dojo/query",
    "dojo/window",
    "dojo/on",
    "dojo/dom-style",
], (declare, _ControllerBase, BrowserListView, DocumentStore, $, win, connectOn, domStyle) ->

    # ## citeplasm/controller/BrowserController
    declare "citeplasm/controller/BrowserController", _ControllerBase,

        listAction: () ->
            @setTitle("Your Documents")
            view = new BrowserListView()
            @setBreadcrumb
                crumbs: [
                    { name: "Your Documents" }
                ]

            @setToolbar
                tools: [
                    { type: "menu", name: "Create", iconClass: "icon-new", children: [
                        { type: "button", name: "Resource", iconClass: "icon-new-resource" },
                        { type: "button", name: "Note", iconClass: "icon-new-note" },
                        { type: "button", name: "Document", iconClass: "icon-new-doc" }
                    ] },
                    { type: "button", name: "Settings", iconClass: "icon-settings" }
                ]
            @setView view
            view.addDocs DocumentStore.query {}, { sort: [{ attribute: 'modified_at', descending: true }] }
            
