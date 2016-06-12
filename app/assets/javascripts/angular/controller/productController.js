  myApp.controller('productController', ['$scope', '$http', function($scope, $http){
    
    
  $scope.title = "Product List";
  $http.get(localhost+"/products.json").then(function(response,status,headers,config){
    $scope.products = response.data;
  },function(data,status,headers, config){
  	alert(data+" "+status+" "+headers+" "+config);
  });
}]);

