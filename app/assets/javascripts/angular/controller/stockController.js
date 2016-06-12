myApp.controller('stockController', ['$scope', '$http', function($scope, $http){
  $scope.title = "Stocks";
  $scope.totalQty = function(){
    
    $scope.sortType     = ''; // set the default sort type
    $scope.sortReverse  = false;  // set the default sort order
    $scope.searchProduct   = '';     // set the default search/filter term
    
  }
  $http.get(localhost+"/stocks.json").then(function(response,status,headers,config){
    $scope.stocks = response.data;
  },function(data,status,headers, config){
  	alert(data+" "+status+" "+headers+" "+config);
  });
}]);