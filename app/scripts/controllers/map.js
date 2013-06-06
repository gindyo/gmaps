(function() {
  angular.module('gmaps').controller('MapCtrl', function($scope, $timeout, $log, $location) {
    google.maps.visualRefresh = true;
    $scope.hide_next_button = true;
    angular.extend($scope, {
      mapIsHidden: true,
      position: {
        coords: {
          latitude: 45,
          longitude: -73
        }
      },
      centerProperty: {
        latitude: 44,
        longitude: -77
      },
      zoomProperty: 4,
      markersProperty: [],
      clickedLatitudeProperty: null,
      clickedLongitudeProperty: null,
      eventsProperty: {
        click: function(mapModel, eventName, originalEventArgs) {
          return $scope.markersProperty = [
            {
              longitude: originalEventArgs[0].latLng.kb,
              latitude: originalEventArgs[0].latLng.jb
            }
          ];
        }
      }
    });
    $scope.address_empty = function() {
      return $scope.address === "" || !$scope.address;
    };
    $scope.submit_coords = function() {
      return $location.path('/success/' + $scope.markersProperty[0].latitude + '&lng=' + $scope.markersProperty[0].longitude);
    };
    return $scope.get_address = function() {
      var callback, geocoder, request;
      request = {
        address: $scope.address
      };
      callback = function(result, status) {
        return $scope.$apply(function() {
          $scope.show_map = true;
          $scope.position.coords = {
            latitude: result[0].geometry.location.jb,
            longitude: result[0].geometry.location.kb
          };
          $scope.markersProperty = null;
          $scope.markersProperty = [
            {
              latitude: result[0].geometry.location.jb,
              longitude: result[0].geometry.location.kb
            }
          ];
          return $scope.zoomProperty = 17;
        });
      };
      geocoder = new google.maps.Geocoder();
      return geocoder.geocode(request, callback);
    };
  });

}).call(this);
