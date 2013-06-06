(function() {
  angular.module('gmaps').controller('MapCtrl', function($scope, $timeout, $log, $location) {
    var steps;
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
    steps = [
      {
        container: $('#view_container'),
        content: '<p>Enter Address</p>',
        highlightTarget: true,
        nextButton: true,
        target: $('#address'),
        my: 'top center',
        at: 'bottom center',
        teardown: function(tour, options) {
          $scope.$apply(function() {
            return $scope.get_address();
          });
          return $scope.mapIsHidden = false;
        }
      }, {
        content: '<p>If the marker is off click where it should be</p>',
        highlightTarget: true,
        nextButton: true,
        target: $('#map'),
        my: 'top center',
        at: 'bottom center'
      }
    ];
    window.tour.options.steps = steps;
    window.tour.start();
    return $scope.get_address = function() {
      var callback, geocoder, request;
      request = {
        address: $scope.address
      };
      callback = function(result, status) {
        return $scope.$apply(function() {
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
