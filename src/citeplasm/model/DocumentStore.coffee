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
# citeplasm/model/DocumentStore is an in-memory data store containing Document
# objects. This is a fixture-like placeholder for a future JSON REST store.
#

define [
    "dojo/_base/declare",
    "dojo/store/Memory",
    "dojo/text!./_fixtures/sample001.html",
    "dojo/text!./_fixtures/sample002.html"
], (declare, Memory, sample001, sample002) ->

    author_josh =
        name: "Joshua D Miller"
        uid: "joshdmiller"

    return new Memory(
        idProperty: "id"
        data: [
                id: 1
                slug: "american-hegemony-in-a-globally-interdependent-age"
                title: "American Hegemony in a Globally-Interdependent Age"
                author: author_josh
                abstract: "This is the abstract for the this document."
                body: sample001
            ,
                id: 2
                slug: "linux-is-not-windows"
                title: "Linux is Not Windows"
                author: author_josh
                abstract: "This is an incomplete blog post about why Linux distributions should not emulate Windows."
                body: sample002
        ]
    )


