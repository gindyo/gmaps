(function() {
  var _this = this;

  $(document).ready(function() {
    Tourist.Tip.Base.prototype.nextButtonTemplate = '<span ng-view><button  ng-hide = "hide_next_button == \'true\'" class="btn btn-primary btn-small pull-right tour-next">Next step →</button> </span>';
    return window.tour = new Tourist.Tour();
  });

}).call(this);
