
var myApp = angular.module('relayapp', []);

// Set up Controllers:
myApp.controller("mainController", function($scope,$http){
	var postURL=""
	$http.get("keys.json").success(function onSuccess(data){
	postURL=data["POSTURL"];
	console.log(postURL); 
	});

	$scope.toggle=function(){
		console.log("Toggle Pressed"); 
		$http.post(postURL,{"args":"toggle"}).success(function onSuccess(data){
			if (data["return_value"]==1){
				$scope.status="On";
			}
			else{
				$scope.status="Off";
			}
			console.log(data["return_value"])
		});
	}

	$scope.getStatus=function(){
		$http.post(postURL,{"args":"status"}).success(function onSuccess(data){
		console.log(data);
		if (data["return_value"]==1){
				$scope.status="On";
			}
			else{
				$scope.status="Off";
			}

		
		});


	}

});


