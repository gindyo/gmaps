(function() {
  angular.module('gmaps').controller('MapCtrl', function($scope, $timeout, $log, $location) {
    var steps, tour,
      _this = this;
    google.maps.visualRefresh = true;
    angular.extend($scope, {
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
          $scope.markersProperty = [
            {
              longitude: originalEventArgs[0].latLng.kb,
              latitude: originalEventArgs[0].latLng.jb
            }
          ];
          $log.log("user defined event on map directive with scope", this);
          return $log.log("user defined event: " + eventName, mapModel, originalEventArgs);
        }
      }
    });
    steps = [
      {
        content: '<p>Enter Address</p>',
        highlightTarget: true,
        nextButton: true,
        target: $('#input'),
        my: 'top center',
        at: 'bottom center',
        teardown: function() {
          return $scope.$apply(function() {
            return $scope.get_address();
          });
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
    tour = null;
    $(document).ready(function() {
      tour = new Tourist.Tour({
        steps: steps,
        successStep: function() {
          return $scope.$apply(function() {
            return $location.path('success/' + $scope.markersProperty[0].latitude + '/' + $scope.markersProperty[0].longitude);
          });
        },
        tipClass: 'Bootstrap',
        tipOptions: {
          showEffect: 'slidein'
        }
      });
      return tour.start();
    });
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
