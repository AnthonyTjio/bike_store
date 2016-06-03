myApp.controller('orderController', ['$scope', '$http', function($scope, $http){
  $scope.title = "Unfinished Orders";
  $http.get(localhost+"/orders.json").then(function(response,status,headers,config){
    $scope.orders = response.data;
  },function(data,status,headers, config){
  	alert(data+" "+status+" "+headers+" "+config);
  });
}]);