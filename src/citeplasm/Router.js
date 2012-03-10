
define(["dojo/_base/declare", "dojo/hash", "dojo/_base/array", "dojo/_base/connect", "dojo/_base/lang", "dojo/io-query"], function(declare, hash, array, connect, lang, ioquery) {
  var PATH_NAME_MATCHER, PATH_REPLACER;
  PATH_REPLACER = "([^\/]+)";
  PATH_NAME_MATCHER = /:([\w\d]+)/g;
  return declare("citeplasm.Router", null, {
    _routes: [],
    _routeCache: {},
    _currentPath: null,
    _subscriptions: [],
    _defaultRoute: null,
    constructor: function(userRoutes) {
      if (!(userRoutes != null) || !userRoutes.length) {
        throw new Error("No routes provided to citeplasm/Router.");
      }
      if (this._routes.length) {
        console.warn("An instance of citeplasm/Router already exists. Continuing anyway.");
      }
      array.forEach(userRoutes, function(r) {
        return this._registerRoute(r.path, r.handler, r.defaultRoute);
      }, this);
      if (!(this._defaultRoute != null)) this._defaultRoute = this._routes[0];
    },
    init: function() {
      this.go(hash() || this._defaultRoute.path);
      return this._subscriptions.push(connect.subscribe("/dojo/hashchange", this, function() {
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
      console.log("citeplasm/Router::_handle Changing current path to '" + hashValue + "'");
      if (hashValue === this._currentPath) return;
      path = hashValue.replace("#", "");
      route = this._chooseRoute(this._getRouteablePath(path) || this._defaultRoute);
      if (!route) return this.go(this._defaultRoute.path);
      params = this._parseParams(path, route);
      route = lang.mixin(route, {
        hash: hashValue,
        params: params
      });
      return route.handler(params, route);
    },
    _chooseRoute: function(path) {
      var routeablePath;
      if (!this._routeCache[path]) {
        routeablePath = this._getRouteablePath(path);
        array.forEach(this._routes, function(r) {
          if (routeablePath.match(r.matcher)) return this._routeCache[path] = r;
        }, this);
      }
      return this._routeCache[path];
    },
    _registerRoute: function(path, fx, defaultRoute) {
      var r;
      r = {
        path: path,
        handler: fx,
        matcher: this._convertPathToMatcher(path),
        paramNames: this._getParamNames(path)
      };
      this._routes.push(r);
      if (defaultRoute) this._defaultRoute = r;
      if (defaultRoute) {
        return console.log("citeplasm/Router::_registerRoute Setting default route to " + path);
      }
    },
    _convertPathToMatcher: function(route) {
      if (lang.isString(route)) {
        return new RegExp("^" + route.replace(PATH_NAME_MATCHER, PATH_REPLACER) + "(/){0,1}$");
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
      var rp;
      return rp = path.split("?")[0];
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
      return array.forEach(this._subscriptions, connect.unsubscribe);
    }
  });
});
