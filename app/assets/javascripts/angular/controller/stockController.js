myApp.controller('stockController', ['$scope', '$http', function($scope, $http){
<<<<<<< HEAD
  $scope.title = "Stocks";
=======
  $scope.title = "TEST";
  $scope.totalQty = function(){
  
  }
>>>>>>> d51b701324195a510afad3b7cdb2923fd78963b6
  $http.get(localhost+"/stocks.json").then(function(response,status,headers,config){
    $scope.stocks = response.data;
  },function(data,status,headers, config){
  	alert(data+" "+status+" "+headers+" "+config);
  });
}]);