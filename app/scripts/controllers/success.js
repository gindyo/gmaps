(function() {
  angular.module('gmaps').controller('SuccessCtrl', function($scope, $routeParams) {
    $scope.latitude = $routeParams.lat;
    return $scope.longitude = $routeParams.lon;
  });

}).call(this);
