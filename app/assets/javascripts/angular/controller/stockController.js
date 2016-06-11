myApp.controller('stockController', ['$scope', '$http', function($scope, $http){
  $scope.title = "TEST";
  $scope.totalQty = function(){
  
  }
  $http.get(localhost+"/stocks.json").then(function(response,status,headers,config){
    $scope.stocks = response.data;
  },function(data,status,headers, config){
  	alert(data+" "+status+" "+headers+" "+config);
  });
}]);