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
# citeplasm/controller/_ControllerBase is the base class from which all
# application controllers should inherit. It is not meant to be instantiated.

# ## RequireJS-style AMD Definition

define [
    "dojo/_base/declare",
    "dojo/_base/connect"
], (declare, connect) ->

    # ## citeplasm/controller/_ControllerBase
    declare "citeplasm/controller/_ControllerBase", null,
        # ### Member Variables

        # baseTitle is the suffix for all titles set in the controller.
        baseTitle: null

        # ### Internal Methods

        # ### Methods for Use in Children

        # #### setTitle
        #
        # This is a convenience method for publishing an event to change the
        # title of the current scene. The Application controller receives these
        # signals and changes the window title.
        setTitle: (title) ->
            if @baseTitle?
                if title?
                    title = "#{title} | #{@baseTitle}"
                else
                    title = @baseTitle
            else
                title ?= ""

            connect.publish "/citeplasm/scenetitle", title

        doAction: (actionName, params) ->
            actionName = actionName + "Action"
            if !@[actionName] or typeof(@[actionName]) isnt "function"
                throw "The action #{actionName} does not exist"

            @[actionName](params)

