  var orderID = $('#orderItemOrderID').val();

  myApp.controller('cartController', ['$scope', '$http', function($scope, $http){
  $scope.title = "Cart";
  $http.get(localhost+"/order_items/"+orderID+".json").then(function(response,status,headers,config){
    $scope.order_items = response.data;
    console.log(response.data);
  },function(data,status,headers, config){
  	alert(data+" "+status+" "+headers+" "+config);
  });
}]);

