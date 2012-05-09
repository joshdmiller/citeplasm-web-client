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

    abstract = """
        Suspendisse sagittis felis sed diam molestie facilisis. Lorem ipsum dolor
        sit amet, consectetur adipiscing elit. In condimentum placerat mattis.
        Nullam ullamcorper blandit massa sed feugiat. Nulla volutpat facilisis
        lectus vehicula venenatis. Phasellus convallis tortor vel nisi
        porttitor fermentum. Class aptent taciti sociosqu ad litora torquent
        per conubia nostra, per inceptos himenaeos. Nam lacus nisi, tristique
        rhoncus vulputate eu, volutpat vitae metus. Aenean accumsan
        pellentesque metus vitae dictum. Vivamus lobortis tincidunt tristique.
        Donec faucibus nunc non ipsum fringilla in dignissim nibh
        malesuada. In hac habitasse platea dictumst. Pellentesque faucibus
        tellus sit amet magna molestie sed sagittis nulla dapibus. Vivamus
        lobortis commodo massa quis gravida. Proin sagittis vestibulum
        dolor, sed porta dui lobortis in.
    """

    return new Memory(
        idProperty: "id"
        data: [
                id: 1
                slug: "american-hegemony-in-a-globally-interdependent-age"
                title: "American Hegemony in a Globally-Interdependent Age"
                author: author_josh
                abstract: abstract
                body: sample001
                modified_at: "2012-05-04T12:32:00-7"
                type: "d"
            ,
                id: 2
                slug: "linux-is-not-windows"
                title: "Linux is Not Windows"
                author: author_josh
                abstract: abstract
                body: sample002
                modified_at: "2012-05-08T15:28:00-7"
                type: "d"
             ,
                id: 3
                slug: "citeplasm-is-cool"
                title: "Citeplasm is Cool"
                author: author_josh
                abstract: abstract
                body: sample002
                modified_at: "2011-12-29T21:27:00-7"
                type: "n"
            ,
                id: 4
                slug: "cosmos-by-carl-sagan"
                title: "Cosmos by Carl Sagan"
                modified_at: "2012-02-29T21:27:00-7"
                type: "r"

        ]
    )


