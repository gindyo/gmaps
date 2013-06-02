'use strict';

angular.module('projectTestApp', []).config ($routeProvider) ->
  $routeProvider
    .when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    })
    .otherwise redirectTo: '/'

