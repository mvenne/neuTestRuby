//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
var app = angular
  .module('app', ['ui.calendar'])
  .controller('appController', ['$scope', function($scope) {

$calendar = $('[ui-calendar]');

  var date = new Date(),
    d = date.getDate(),
    m = date.getMonth(),
    y = date.getFullYear();

  $scope.changeView = function(view){
    $calendar.fullCalendar('changeView',view);
};

 /* config object */
$scope.uiConfig = {
  calendar: {
    lang: 'de',
    height: '100%',
    editable: true,
    header: {
//left: 'month basicWeek basicDay',
//center: 'title',
right: 'today prev,next'
},
eventClick: function(date, jsEvent, view) {
  $scope.alertMessage = (date.title + ' was clicked ');
},
dayClick: $scope.alertEventOnClick,
eventDrop: $scope.alertOnDrop,
eventResize: $scope.alertOnResize,
eventRender: $scope.eventRender
}
};

$scope.events = [{
  title: 'All Day Event',
  start: new Date(y, m, 1)
}, {
  title: 'Long Event',
  start: new Date(y, m, d - 5),
  end: new Date(y, m, d - 2)
}, {
  id: 999,
  title: 'Repeating Event',
  start: new Date(y, m, d - 3, 16, 0),
  allDay: false
}, {
  id: 999,
  title: 'Repeating Event',
  start: new Date(y, m, d + 4, 16, 0),
  allDay: false
}, {
  title: 'Birthday Party',
  start: new Date(y, m, d + 1, 19, 0),
  end: new Date(y, m, d + 1, 22, 30),
  allDay: false
}, {
  title: 'Click for Google',
  start: new Date(y, m, 28),
  end: new Date(y, m, 29),
  url: 'http://google.com/'
}];

$scope.eventSources = [$scope.events];
}]);