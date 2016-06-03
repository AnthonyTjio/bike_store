  myApp.controller('customerController', ['$scope', '$http', function($scope, $http){
  $scope.title = "Customer List";
  $http.get(localhost+"/customers.json").then(function(response,status,headers,config){
    $scope.customers = response.data;
  },function(data,status,headers, config){
  	alert(data+" "+status+" "+headers+" "+config);
  });
}]);

