(function() {
  'use strict';
  angular.module('gmaps', ['google-maps']).config(function($routeProvider) {
    return $routeProvider.when('/', {
      templateUrl: 'views/map.html',
      controller: 'MapCtrl'
    }).when('/success/:lat/:lon', {
      templateUrl: 'views/success.html',
      controller: 'SuccessCtrl'
    }).otherwise({
      redirectTo: '/'
    });
  });

}).call(this);
