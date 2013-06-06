$(document).ready =>
  Tourist.Tip.Base.prototype.nextButtonTemplate = '<span ng-view><button  ng-hide = "hide_next_button == \'true\'" class="btn btn-primary btn-small pull-right tour-next">Next step →</button> </span>'
  window.tour = new Tourist.Tour();

  