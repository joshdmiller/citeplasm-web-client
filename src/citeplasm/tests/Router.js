
define(["../Router"], function(Router) {
  var routes, routesWithoutDefault;
  routes = [
    {
      path: "/test/sub",
      handler: function() {}
    }, {
      path: "/test",
      handler: function() {},
      defaultRoute: true
    }, {
      path: "/param/:id",
      handler: function() {}
    }
  ];
  routesWithoutDefault = [
    {
      path: "/test",
      handler: function() {}
    }, {
      path: "/test/sub",
      handler: function() {}
    }
  ];
  return doh.register("citeplasm/Router", [
    {
      name: "It should throw an Error if initialized without routes.",
      runTest: function(t) {
        var r;
        try {
          r = new Router();
        } catch (e) {
          t.t(e instanceof Error);
          return true;
        }
        throw "Did not catch an error!";
      }
    }, {
      name: "It should throw an Error if initialized with an empty array.",
      runTest: function(t) {
        var r;
        try {
          r = new Router([]);
        } catch (e) {
          t.t(e instanceof Error);
          return true;
        }
        throw "Did not catch an error!";
      }
    }, {
      name: "It should initialize correctly with a set of proper routes.",
      runTest: function(t) {
        var router;
        router = new Router(routes);
        return t.t(router instanceof Router);
      }
    }, {
      name: "It should set the default route when provided explicitly.",
      runTest: function(t) {
        var router;
        router = new Router(routes);
        return t.is(router._defaultRoute.path, routes[1].path);
      }
    }, {
      name: "It should set the default route to the first route when not provided excplicitly.",
      runTest: function(t) {
        var router;
        router = new Router(routesWithoutDefault);
        return t.is(router._defaultRoute.path, routesWithoutDefault[0].path);
      }
    }, {
      name: "Parameter names should be properly pulled from the route path.",
      runTest: function(t) {
        var router;
        router = new Router(routes);
        return t.is(router._routes[2].paramNames, ["id"]);
      }
    }
  ]);
});
