var taskControllers = angular.module('taskControllers', []);

taskControllers.controller('TaskListCtrl', ['$scope', 'Task', function ($scope, Task) {

  $scope.newTask = new Task(); 
  
  $scope.tasks = Task.query();

  $scope.submit = function() {
    if ($scope.newTask.title) {
      Task.save($scope.newTask, function() {
        $scope.tasks = Task.query();
      });
    }
  };

  $scope.toggle = function(task) {
    task.done = !task.done;
    task.$update();
  };

  $scope.remove = function(task) {
    task.$remove(function() {
        $scope.tasks = Task.query();
    });
  };


}]);

