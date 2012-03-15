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

define [
    "../DocumentStore"
], (DocumentStore) ->
    records = DocumentStore.query()
    
    doh.register "citeplasm/model/DocumentStore", [
        
            name: "It should contain two records."
            runTest: (t) ->
                t.is 2, records.length
        ,
            name: "It should follow the dojo.store API."
            runTest: (t) ->
                one = DocumentStore.get 1
                t.is "joshdmiller", one.author.uid
    ]

