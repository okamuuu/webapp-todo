var taskServices = angular.module('taskServices', ['ngResource']);

taskServices.factory('Task', ['$resource',
  function($resource){
    return $resource('/api/tasks/:id', {}, {
      update: { method:'PUT', params:{id:'@id'}},
      remove: { method:'DELETE', params:{id:'@id'}}
    });
  }]);
