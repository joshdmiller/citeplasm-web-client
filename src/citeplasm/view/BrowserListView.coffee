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
# citeplasm/view/BrowserListView is a view listing all available documents,
# filterable by certain criteria.

# ## RequireJS-style AMD Definition
define [
    "dojo/_base/declare",
    "dijit/_WidgetBase",
    "dijit/_WidgetsInTemplateMixin",
    "dijit/_TemplatedMixin",
    "dojo/text!./templates/BrowserListView.html",
    "dojo/dom",
    "dojo/_base/array",
    "dojo/dom-construct",
    "dojo/date",
    "dojo/date/locale",
    "dojo/date/stamp",
    "citeplasm/widget/Editor"
], (declare, _WidgetBase, _WidgetsInTemplateMixin, _TemplatedMixin, template, dom, array, domConstruct, date, locale, stamp) ->

    # ## citeplasm/view/BrowserListView
    #
    # citeplasm/view/BrowserListView is defined using Dojo's declare, based on dijit's
    # _WidgetBase and _Templated.
    declare "citeplasm/view/BrowserListView", [_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin],

        # The templateString is used by _TemplatedMixin to create a widget
        # based on an HTML template. In this case, we are passing the raw
        # contents of 'templates/Interface.html'.
        templateString: template

        # The baseClass is a CSS class applied to the root element of the
        # template.
        baseClass: "citeplasmBrowserList"

        addDocs: (docs) ->
            tableBody = "#{@id}-table-body"
            tbody = dom.byId(tableBody)
            array.forEach docs, (doc) ->
                # Convert the date from an ISO date string to a Date object.
                dt = stamp.fromISOString doc.modified_at

                # To do some date math, here's today's and yesterday's dates.
                today = new Date()
                yesterday = date.add today, "day", -1

                # We select the format based on how long ago it was
                fmt = ""
                console.log "Dt=#{locale.format(dt)}; difference is #{date.difference(today, dt)}"
                if date.difference(today, dt) is 0
                    fmt = locale.format dt,
                        selector: 'time'
                else if date.difference(dt, yesterday) is 0
                    fmt = "Yesterday"
                else if dt.getFullYear() is today.getFullYear()
                    fmt = locale.format dt,
                        selector: 'date'
                        formatLength: 'medium'
                else
                    fmt = locale.format dt,
                        selector: 'date'
                        formatLength: 'short'

                # Create the table row.
                tr = domConstruct.create "tr", {}, tbody
                td_title = domConstruct.create "td", { innerHTML: "<a href='#/documents/#{doc.id}'><i class='icon-#{doc.type}'></i>#{doc.title}</a>" }, tr
                td_mod = domConstruct.create "td", { innerHTML: fmt }, tr

