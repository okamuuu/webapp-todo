var taskApp = angular.module('taskApp', [
  'ngRoute',
  'taskControllers',
  'taskServices'
]);

taskApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/tasks', {
        templateUrl: 'partials/task-list.html',
        controller: 'TaskListCtrl'
      }).
//      when('/tasks/:id', {
//        templateUrl: 'partials/task-detail.html',
//        controller: 'TaskDetailCtrl'
//      }).
      otherwise({
        redirectTo: '/tasks'
      });
  }]);
