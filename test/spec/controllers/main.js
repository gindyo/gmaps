(function() {
  describe('MainCtrl', function() {
    var controller, scope,
      _this = this;

    controller = null;
    scope = {};
    beforeEach(module('projectTestApp'));
    beforeEach(inject(function($injector) {
      scope = $injector.get('$rootScope').$new;
      return controller = $injector.get('$controller')('MainCtrl', {
        $scope: scope
      });
    }));
    return it('has awesomeThins', function() {
      return expect(scope.awesomeThings.length).toEqual(3);
    });
  });

  describe('MyService', function() {
    var my_s;

    my_s = {};
    beforeEach(module('Services'));
    beforeEach(inject(function($injector) {
      return my_s = $injector.get('MyService');
    }));
    return it('tests MyService', function() {
      return console.log(my_s.dimitar);
    });
  });

}).call(this);
