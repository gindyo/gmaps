angular.module('gmaps').controller 'MapCtrl', ($scope, $timeout, $log, $location)->
  google.maps.visualRefresh = true;
  $scope.hide_next_button = true# $scope.address == ''
  angular.extend $scope, 
    mapIsHidden: true
    position: 
      coords: 
        latitude: 45,
        longitude: -73
   #/** the initial center of the map */
    centerProperty: 
      latitude: 44
      longitude: -77
   #/** the initial zoom level of the map */
    zoomProperty: 4
    #/** list of markers to put in the map */
    markersProperty: []
    #// These 2 properties will be set when clicking on the map
    clickedLatitudeProperty: null  
    clickedLongitudeProperty: null
    
    eventsProperty: 
      click: (mapModel, eventName, originalEventArgs)->  
        $scope.markersProperty = [{longitude: originalEventArgs[0].latLng.kb, latitude: originalEventArgs[0].latLng.jb }]

  $scope.address_empty = ->
    $scope.address == "" || !$scope.address 

  $scope.submit_coords = ->
    $location.path '/success/'+$scope.markersProperty[0].latitude+'&lng='+$scope.markersProperty[0].longitude
    

  $scope.get_address = ->
    request = {
      address: $scope.address
    }
    callback = (result, status)->
      $scope.$apply ->
        $scope.show_map= true
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
  
    