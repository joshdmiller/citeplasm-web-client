
define(["../Router"], function(Router) {
  var createRouter, routes, routesWithoutDefault;
  routes = [
    {
      path: "/test/sub",
      handler: function() {}
    }, {
      path: "/test",
      handler: function() {},
      defaultRoute: true
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
  createRouter = function() {
    return this.router = new Router(routes);
  };
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
      setUp: createRouter,
      runTest: function(t) {
        return t.t(this.router instanceof Router);
      }
    }, {
      name: "It should set the default route when provided explicitly.",
      setUp: createRouter,
      runTest: function(t) {
        return t.is(this.router._defaultRoute.path, routes[1].path);
      }
    }, {
      name: "It should set the default route to the first route when not provided excplicitly.",
      setUp: function() {
        return this.router = new Router(routesWithoutDefault);
      },
      runTest: function(t) {
        return t.is(this.router._defaultRoute.path, routesWithoutDefault[1].path);
      }
    }
  ]);
});
