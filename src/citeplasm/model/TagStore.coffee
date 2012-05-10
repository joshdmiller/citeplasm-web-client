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
# citeplasm/model/TagStore is an in-memory data store containing Tag
# objects. This is a fixture-like placeholder for a future JSON REST store.
#

define [
    "dojo/_base/declare",
    "dojo/store/Memory"
], (declare, Memory) ->

    return new Memory
        idProperty: "name"
        data: [
                name: "science"
                count: 20
            ,
                name: "evolution"
                count: 12
            ,
                name: "physics"
                count: 6
            ,
                name: "philosophy"
                count: 12
            ,
                name: "history"
                count: 5
            ,
                name: "united-states"
                count: 3
        ]
        
        getChildren: (object) ->
            @query {parent: object.tag}

