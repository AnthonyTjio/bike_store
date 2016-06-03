  myApp.controller('userController', ['$scope', '$http', function($scope, $http){
  $scope.title ="Users List";
  $http.get(localhost+"/home/userlist.json").then(function(response,status,headers,config){
    $scope.users = response.data;
  },function(data,status,headers, config){
  	alert(data+" "+status+" "+headers+" "+config);
  });
}]);

