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
    "citeplasm/model/DocumentStore",
], (declare, _ControllerBase, DocumentShowView, DocumentStore) ->

    # ## citeplasm/controller/DocumentController
    declare "citeplasm/controller/DocumentController", _ControllerBase,

        pre: () ->
            @doc = DocumentStore.get @params.id
            # TODO handle non-existent doc
            if @doc?
                @baseTitle = @doc.title

        viewAction: () ->
            @setTitle()
            view = new DocumentShowView()
            @setView(view)
            @setBreadcrumb
                crumbs: [
                    { name: "Your Documents", url: "#/documents" },
                    { name: @baseTitle }
                ]
            view.setBody @doc.body
            view.setTitle @doc.title
            view.setAuthor @doc.author.uid, @doc.author.name
            view.setAbstract @doc.abstract

        editAction: () ->
            @setTitle("Editing")
            @setBreadcrumb
                crumbs: [
                    { name: "Your Documents", url: "#/documents" },
                    { name: @baseTitle, url: "#/documents/#{@doc.id}" },
                    { name: "Editing" }
                ]
 
