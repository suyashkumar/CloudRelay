
var myApp = angular.module('relayapp', []);
// Set up Controllers:
myApp.controller("mainController", function($scope,$http){
	
	$scope.toggle=function(){
		console.log("Toggle Pressed");

		$http.post("https://api.particle.io/v1/devices/250025001747343338333633/led?access_token=97bbe3755d84dc951179331beacf98cb93b4b6b0",{"args":"toggle"}).success(function onSuccess(data){
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
		$http.post("https://api.particle.io/v1/devices/250025001747343338333633/led?access_token=97bbe3755d84dc951179331beacf98cb93b4b6b0",{"args":"status"}).success(function onSuccess(data){
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


