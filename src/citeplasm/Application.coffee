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
# citeplasm/Application provides the application logic for the Citeplasm Web App.

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "citeplasm/Interface",
    "dojo/_base/window"
], (declare, Interface, win) ->

    # ## citeplasm/Application
    declare "citeplasm/Application", null,
        # ### Member Variables

        # _interface is a reference to the citeplasm/Interface widget
        _interface: null

        # ### constructor
        #
        # The constructor instantiates Application, but also adds
        # citeplasm/Interface to the document body.
        constructor: () ->
            @_initUi( win.body() )

        # ### _initUi
        #
        # _initUi instantiates the citeplasm/Interface into the provided dom
        # object and initializes its state.
        _initUi: (container) ->
            @_interface = new Interface()
            @_interface.placeAt(container)
            @_interface.startup()

