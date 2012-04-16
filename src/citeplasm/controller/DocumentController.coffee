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
# citeplasm/controller/DocumentController is the base class from which all
# application controllers should inherit. It is not meant to be instantiated.

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "citeplasm/controller/_ControllerBase",
    "citeplasm/view/DocumentShowView",
    "citeplasm/view/DocumentEditView",
    "citeplasm/model/DocumentStore",
    "dojo/query",
    "dojo/window",
    "dojo/on",
    "dojo/dom-style",
], (declare, _ControllerBase, DocumentShowView, DocumentEditView, DocumentStore, $, win, connectOn, domStyle) ->

    # ## citeplasm/controller/DocumentController
    declare "citeplasm/controller/DocumentController", _ControllerBase,

        pre: () ->
            @doc = DocumentStore.get @params.id
            # TODO handle non-existent doc
            if @doc?
                @baseTitle = @doc.title

        viewAction: () ->
            @setTitle()
            view = new DocumentShowView
                docId: @doc.id
                docBody: @doc.body
                docTitle: @doc.title
                docAuthorId: @doc.author.uid
                docAuthorName: @doc.author.name
                docAbstract: @doc.abstract

            @setView(view)
            @setBreadcrumb
                crumbs: [
                    { name: "Your Documents", url: "#/documents" },
                    { name: @baseTitle }
                ]

        editAction: () ->
            @setTitle("Editing")
            view = new DocumentEditView
                docBody: @doc.body
                docId: @doc.id

            @setView(view)
            @setBreadcrumb
                crumbs: [
                    { name: "Your Documents", url: "#/documents" },
                    { name: @baseTitle, url: "#/documents/#{@doc.id}" },
                    { name: "Editing" }
                ]
            
            resizeEditor = () ->
                $(".dijitEditorIFrameContainer, iframe", dojo.byId(view.id + "-documentEditor")).forEach (el) ->
                    winHeight = win.getBox().h
                    height = winHeight - 159
                    domStyle.set el, "height", height + "px"

            connectOn window, "resize", resizeEditor

            resizeEditor()

