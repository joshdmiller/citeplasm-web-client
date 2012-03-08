/**
 * This file is your application’s main JavaScript file. It is listed as a dependency in run.js and will
 * automatically load when run.js loads.
 *
 * Because this file has the special filename “main.js”, and because we’ve registered the “app” package in run.js,
 * whatever object this module returns can be loaded by other files simply by requiring “app” (instead of “app/main”).
 *
 * ---
 *
 * Citeplasm is a model-view-controller application with one scene that has
 * multiple child views. The #main element in the HTML page is a container for
 * views to be instantiated by a controller.
 *
 * citeplasm/view/_View is the base widget for all views. It inherits dijit/layout/ContentPane.
 * citeplasm/controller/_Controller is the base class for all controllers.
 * citeplasm/model contains all classes for communicating with the Citeplasm REST API.
 *
 * citeplasm/Router is a routing engine based in part on dbp/Router.
 */
define([ 'dojo/parser', 'citeplasm/Interface', 'dojo/domReady!' ], function (parser) {
    parser.parse();
});
