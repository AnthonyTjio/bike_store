  myApp.controller('modelController', ['$scope', '$http', function($scope, $http){
    $scope.sortType     = ''; // set the default sort type
    $scope.sortReverse  = false;  // set the default sort order
    $scope.searchModel   = '';     // set the default search/filter term
    
  $scope.title = "Model List";
  $http.get(localhost+"/bike_models.json").then(function(response,status,headers,config){
    $scope.bike_models = response.data;
  },function(data,status,headers, config){
  	alert(data+" "+status+" "+headers+" "+config);
  });
}]);

