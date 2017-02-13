//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
var app = angular
    .module('app', ['ui.calendar'])
    .controller('appController', ['$scope', function($scope) {
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var currentView = "month";


        //event source that pulls from google.com
        $scope.eventSource = {
        };


        //This will call onLoad and you can assign the values the way you want to the calendar
        //here DataRetriever.jsp will give me array of JSON data generated from the database data
        /*
         $http.get('DataRetriever.jsp').success(function(data) {
         for(var i = 0; i < data.length; i++)
         {
         $scope.events[i] = {id:data[i].id, title: data[i].task,start: new Date(data[i].start), end: new Date(data[i].end),allDay: false};
         }
         });
         */
        /*
         //to explicitly add events to the calendar
         //you can add the events in following ways
         $scope.events = [
         {title: 'All Day Event',start: new Date('Thu Oct 17 2013 09:00:00 GMT+0530 (IST)')},
         {title: 'Long Event',start: new Date('Thu Oct 17 2013 10:00:00 GMT+0530 (IST)'),end: new Date('Thu Oct 17 2013 17:00:00 GMT+0530 (IST)')},
         {id: 999,title: 'Repeating Event',start: new Date('Thu Oct 17 2013 09:00:00 GMT+0530 (IST)'),allDay: false},
         {id: 999,title: 'Repeating Event',start: new Date(y, m, d + 4, 16, 0),allDay: false},
         {title: 'Birthday Party',start: new Date(y, m, d + 1, 19, 0),end: new Date(y, m, d + 1, 22, 30),allDay: false},
         {title: 'Click for Google',start: new Date(y, m, 28),end: new Date(y, m, 29),url: 'http://google.com/'}
         ];
         //we don't need it right now*/


        //with this you can handle the events that generated by clicking the day(empty spot) in the calendar
        $scope.dayClick = function( date, allDay, jsEvent, view ){
            $scope.$apply(function(){
                $scope.alertMessage = ('Day Clicked ' + date);
            });
        };


        //with this you can handle the events that generated by droping any event to different position in the calendar
        $scope.alertOnDrop = function(event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view){
            $scope.$apply(function(){
                $scope.alertMessage = ('Event Droped to make dayDelta ' + dayDelta);
            });
        };


        //with this you can handle the events that generated by resizing any event to different position in the calendar
        $scope.alertOnResize = function(event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view ){
            $scope.$apply(function(){
                $scope.alertMessage = ('Event Resized to make dayDelta ' + minuteDelta);
            });
        };

        /*
         //this code will add new event and remove the event present on index
         //you can call it explicitly in any method
         $scope.events.push({
         title: 'New Task',
         start: new Date(y, m, 28),
         end: new Date(y, m, 29),
         className: ['newtask']
         });

         $scope.events.splice(index,1);*/


        //with this you can handle the click on the events
        $scope.eventClick = function(event){
            $scope.$apply(function(){
                $scope.alertMessage = (event.title + ' is clicked');
            });
        };


        //with this you can handle the events that generated by each page render process
        $scope.renderView = function(view){
            var date = new Date(view.calendar.getDate());
            $scope.currentDate = date.toDateString();
            $scope.$apply(function(){
                $scope.alertMessage = ('Page render with date '+ $scope.currentDate);
            });
        };


        //with this you can handle the events that generated when we change the view i.e. Month, Week and Day
        $scope.changeView = function(view,calendar) {
            currentView = view;
            calendar.fullCalendar('changeView',view);
            $scope.$apply(function(){
                $scope.alertMessage = ('You are looking at '+ currentView);
            });
        };


        /* config object */
        $scope.uiConfig = {
            calendar:{
                height: 500,
                editable: true,
                header:{
                    left: 'month basicWeek basicDay agendaWeek agendaDay',
                    center: 'title',
                    right: 'today prev,next'
                },
                dayClick: $scope.dayClick,
                eventDrop: $scope.alertOnDrop,
                eventResize: $scope.alertOnResize,
                eventClick: $scope.eventClick,
                viewRender: $scope.renderView
            }
        };

        /* event sources array*/
        $scope.eventSources = [$scope.events, $scope.eventSource, $scope.eventsF];
    }]);