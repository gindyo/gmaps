describe 'MainCtrl', ->
  controller = null
  scope = {}
  
  
  beforeEach module 'gmaps'
  
  beforeEach inject ($injector)=>
    scope =  $injector.get('$rootScope').$new
    controller = $injector.get('$controller')('MainCtrl', {$scope: scope})

  it 'has awesomeThins', ()=>
    expect(scope.awesomeThings.length).toEqual 3

describe 'MyService', ->
  my_s = {}
  beforeEach module('Services')

  beforeEach inject ($injector)->
    my_s = $injector.get('MyService')

  it 'tests MyService', ->
    console.log my_s.dimitar