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
# citeplasm/model/FolderStore is an in-memory data store containing Folder
# objects. This is a fixture-like placeholder for a future JSON REST store.
#

define [
    "dojo/_base/declare",
    "dojo/store/Memory"
], (declare, Memory) ->

    return new Memory
        idProperty: "id"
        data: [
                id: 0
                name: "Root"
            ,
                id: 1
                name: "Science"
                parent: 0
            ,
                id: 2
                name: "Evolution"
                parent: 1
            ,
                id: 3
                name: "Physics"
                parent: 1
            ,
                id: 4
                name: "Philosophy"
                parent: 0
            ,
                id: 5
                name: "History"
                parent: 0
            ,
                id: 6
                name: "United States"
                parent: 5
        ]
        
        getChildren: (object) ->
            @query {parent: object.id}

