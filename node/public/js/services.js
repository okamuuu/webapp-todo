var taskServices = angular.module('taskServices', ['ngResource']);

taskServices.factory('Task', ['$resource',
  function($resource){
    return $resource('/api/tasks/:key', {}, {
      update: { method:'PUT', params:{key:'@_key'}},
      remove: { method:'DELETE', params:{key:'@_key'}}
    });
  }]);
