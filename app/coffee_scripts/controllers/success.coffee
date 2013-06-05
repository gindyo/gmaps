angular.module('gmaps').controller 'SuccessCtrl', ($scope, $routeParams)->
  $scope.latitude = $routeParams.lat
  $scope.longitude = $routeParams.lon