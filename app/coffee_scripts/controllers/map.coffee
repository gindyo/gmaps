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
 
  steps = [
    {
      container: $('#view_container')
      content: '<p>Enter Address</p>',
      highlightTarget: true,
      nextButton: true,
      target: $('#address'),
      my: 'top center',
      at: 'bottom center'
      teardown:  (tour, options) ->
        $scope.$apply -> $scope.get_address()
        $scope.mapIsHidden = false
      
    },
    {
      content: '<p>If the marker is off click where it should be</p>',
      highlightTarget: true,
      nextButton: true,
      target: $('#map'),
      my: 'top center',
      at: 'bottom center'
    }]

  window.tour.options.steps = steps
  window.tour.start()

 

  # $(document).ready =>
  #   Tourist.Tip.Base.prototype.nextButtonTemplate = '<button ng-hide = "hide_next_button" class="btn btn-primary btn-small pull-right tour-next">Next step →</button>'
  #   tour = new Tourist.Tour({
  #     steps: steps,
  #     successStep: ->
  #       $scope.$apply ->
  #         $location.path 'success/'+$scope.markersProperty[0].latitude+'/'+$scope.markersProperty[0].longitude

  #     tipClass: 'Bootstrap',
  #     tipOptions:{ showEffect: 'slidein' }
  #     stepOptions:
  #       $scope: $scope 
  #   });
  #   tour.start();

  

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
  
    