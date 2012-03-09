
define(["dojo/_base/declare", "dojo/hash", "dojo/_base/array", "dojo/_base/connect", "dojo/_base/lang", "dojo/io-query"], function(declare, hash, array, connect, lang, ioquery) {
  var PATH_NAME_MATCHER, PATH_REPLACER, currentPath, routeCache, routes, subscriptions;
  routes = [];
  routeCache = {};
  currentPath = null;
  subscriptions = [];
  PATH_REPLACER = "([^\/]+)";
  PATH_NAME_MATCHER = /:([\w\d]+)/g;
  return declare("citeplasm.Router", null, {
    constructor: function(userRoutes) {
      console.log(userRoutes);
      if (!userRoutes || !userRoutes.length) {
        throw "No routes provided to citeplasm/Router.";
      }
      if (routes.length) {
        console.warn("An instance of citeplasm/Router already exists. Continuing anyway.");
      }
      array.forEach(userRoutes, function(r) {
        console.log("citeplasm/Router::constructor is registering route '" + r.path + "'");
        return this._registerRoute(r.path, r.handler, r.defaultRoute);
      }, this);
      if (!this.defaultRoute) this.defaultRoute = userRoutes[0];
    },
    init: function() {
      console.log("citeplasm/Router::init with current hash as " + hash());
      this.go(hash() || this.defaultRoute.path);
      return subscriptions.push(connect.subscribe("/dojo/hashchange", this, function() {
        console.log("citeplasm/Router received /dojo/hashchange");
        this._handle(hash());
      }));
    },
    go: function(path) {
      console.log("citeplasm/Router::go(" + path + ")");
      path = lang.trim(path);
      if (!path) return;
      this._handle(path);
      if (path.indexOf("#") !== 0) path = "#" + path;
      return hash(path);
    },
    _handle: function(hashValue) {
      var params, path, route;
      if (hashValue === currentPath) return;
      path = hashValue.replace("#", "");
      route = this._chooseRoute(this._getRouteablePath(path) || this.defaultRoute);
      params = this._parseParams(path, route);
      route = lang.mixin(route, {
        hash: hashValue,
        params: params
      });
      return route.handler(params, route);
    },
    _chooseRoute: function(path) {
      var routeablePath;
      if (!routeCache[path]) {
        routeablePath = this._getRouteablePath(path);
        array.forEach(routes, function(r) {
          if (routeablePath.match(r.matcher)) return routeCache[path] = r;
        });
      }
      return routeCache[path];
    },
    _registerRoute: function(path, fx, defaultRoute) {
      var r;
      r = {
        path: path,
        handler: fx,
        matcher: this._convertPathToMatcher(path),
        paramNames: this._getParamNames(path)
      };
      routes.push(r);
      if (defaultRoute) return this.defaultRoute = r;
    },
    _convertPathToMatcher: function(route) {
      if (lang.isString(route)) {
        return new RegExp("^" + route.replace(PATH_NAME_MATCHER, PATH_REPLACER) + "$");
      } else {
        return route;
      }
    },
    _parseParams: function(hashValue, route) {
      var params, parts, path, pathParams, query, _decode;
      parts = hashValue.split("?");
      path = parts[0];
      query = parts[1];
      _decode = decodeURIComponent;
      params = query ? lang.mixin({}, ioquery.queryToObject(query)) : {};
      if (pathParams = route.matcher.exec(this._getRouteablePath(path) !== null)) {
        parseParams.shift();
        array.forEach(pathParams, function(param, i) {
          if (route.paramNames[i]) {
            return params[route.paramNames[i]] = _decode(param);
          } else {
            if (!params.splat) params.splat = [];
            return params.splat.push(_decode(param));
          }
        });
      }
      return params;
    },
    _getRouteablePath: function(path) {
      return path.split("?")[0];
    },
    _getParamNames: function(path) {
      var paramNames, pathMatch;
      paramNames = [];
      PATH_NAME_MATCHER.lastIndex = 0;
      while (pathMatch = PATH_NAME_MATCHER.exec(path) !== null) {
        paramNames.push(pathMatch[1]);
      }
      return paramNames;
    },
    destroy: function() {
      return array.forEach(subscriptions, connect.unsubscribe);
    }
  });
});
