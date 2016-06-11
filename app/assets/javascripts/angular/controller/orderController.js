myApp.controller('orderController', ['$scope', '$http', function($scope, $http){
    
    $scope.sortType     = ''; // set the default sort type
    $scope.sortReverse  = false;  // set the default sort order
    $scope.searchCustomer   = '';     // set the default search/filter term
    
$http.get(localhost+"/orders.json").then(function(response,status,headers,config){
        $scope.orders = response.data;
        console.log($scope.orders)
      },function(data,status,headers, config){
      	alert(data+" "+status+" "+headers+" "+config);
      });
}]);      

myApp.controller('NewOrderItemController', ['$scope', '$http', function($scope, $http){
  // $scope.title = "Unfinished Orders";
  
    
  
  $scope.tabs = [{
		title: 'Step One',
		url: 'tabOne.html'
	}, {
		title: 'Step Two',
		url: 'tabTwo.html'
	}, {
		title: 'Step Three',
		url: 'tabThree.html'
	}];

	$scope.currentTab = 'tabOne.html';

    $scope.onClickTab = function (tab) {
    // 	if(tab.url == 'tabThree.html')
    // 	{
    // 		alert('cannot access');
    // 	}
    // 	else{
    		$scope.currentTab = tab.url;
    // 	}  
    }
  
    $scope.moveToFirstTab = function () {
    		$scope.currentTab = $scope.tabs[0].url;
    };
    
     $scope.backToFirstTab = function () {
    		$scope.currentTab = $scope.tabs[0].url;
    };
    
    
    $scope.moveToSecondTab = function () {
        // console.log('taik')
  		//$scope.currentTab = $scope.tabs[1].url;
    };
    
    $scope.backToSecondTab = function () {
    		$scope.currentTab = $scope.tabs[1].url;
    };
    
    $scope.moveToThirdTab = function () {
    		$scope.currentTab = $scope.tabs[2].url;
    };
    
    $scope.isActiveTab = function(tabUrl) {
        return tabUrl == $scope.currentTab;
    };
    
}]);