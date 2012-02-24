/**
 * An HTML5 document editor.
 */
define([ 
        'dojo/_base/declare',
        'dijit/_WidgetBase', 
        'dijit/_TemplatedMixin',
        'dojo/text!./templates/Editor.html' 
], function (
    declare, 
    _WidgetBase, 
    _TemplatedMixin,
    template
) {
    return declare("citeplasm.Editor", [_WidgetBase, _TemplatedMixin], {
        author: "Undeclared Author",
        title: "Untitled Document",
        baseClass: "CiteplasmEditor",
        templateString: template
    });
});
