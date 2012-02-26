/**
 * An HTML5 document editor.
 */
define([ 
        'dojo/_base/declare',
        'dijit/_WidgetBase', 
        'dijit/_TemplatedMixin',
        'dijit/_WidgetsInTemplateMixin',
        'dojo/text!./templates/Editor.html',
        'dijit/form/Button'
], function (
    declare, 
    _WidgetBase, 
    _TemplatedMixin,
    _WidgetsInTemplate,
    template
) {
    return declare("citeplasm.Editor", [_WidgetBase, _TemplatedMixin, _WidgetsInTemplate], {
        author: "Undeclared Author",
        title: "Untitled Document",
        baseClass: "CiteplasmEditor",
        templateString: template
    });
});
