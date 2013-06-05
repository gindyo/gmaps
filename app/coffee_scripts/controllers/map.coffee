angular.module('gmaps').controller 'MapCtrl', ($scope, $timeout, $log, $location)->
  google.maps.visualRefresh = true;
  
  angular.extend $scope, {
    position: {
      coords: {
        latitude: 45,
        longitude: -73
        }
      },
    
    #/** the initial center of the map */
    centerProperty: {
      latitude: 44
      longitude: -77
    },
    
    #/** the initial zoom level of the map */
    zoomProperty: 4,
    
    #/** list of markers to put in the map */
    markersProperty: []
    
    #// These 2 properties will be set when clicking on the map
    clickedLatitudeProperty: null  
    clickedLongitudeProperty: null
    
    eventsProperty: 
      click: (mapModel, eventName, originalEventArgs)->  

        $scope.markersProperty = [{longitude: originalEventArgs[0].latLng.kb, latitude: originalEventArgs[0].latLng.jb }]
        

        # // 'this' is the directive's scope
        $log.log("user defined event on map directive with scope", this);
        $log.log("user defined event: " + eventName, mapModel, originalEventArgs);
  }

  steps = [{
    content: '<p>Enter Address</p>',
    highlightTarget: true,
    nextButton: true,
    target: $('#input'),
    my: 'top center',
    at: 'bottom center',
    teardown: -> $scope.$apply -> $scope.get_address()
  }, {
    content: '<p>If the marker is off click where it should be</p>',
    highlightTarget: true,
    nextButton: true,
    target: $('#map'),
    my: 'top center',
    at: 'bottom center'

  }]
 

  tour = null
  $(document).ready =>
    tour = new Tourist.Tour({
      steps: steps,
      successStep: -> $scope.$apply ->
        $location.path 'success/'+$scope.markersProperty[0].latitude+'/'+$scope.markersProperty[0].longitude
      tipClass: 'Bootstrap',
      tipOptions:{ showEffect: 'slidein' }
    });
    tour.start();


  $scope.get_address = ->
    request = {
      address: $scope.address
    }
    callback = (result, status)->
      $scope.$apply ->
        $scope.position.coords = {
          latitude: result[0].geometry.location.jb
          longitude: result[0].geometry.location.kb
        }
        $scope.markersProperty = null
        $scope.markersProperty = [{
          latitude: result[0].geometry.location.jb
          longitude: result[0].geometry.location.kb
        }]
        $scope.zoomProperty = 17
    geocoder = new google.maps.Geocoder()
    geocoder.geocode(request, callback)
  
    