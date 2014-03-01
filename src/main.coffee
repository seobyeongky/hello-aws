angular.module('test',['btford.socket-io'])
	.factory 'mySocket', (socketFactory) ->
		socketFactory()
	.controller 'MainCtrl', ($scope,mySocket) ->
		$scope.value = 'main'
		mySocket.on 'news', (data) ->
			$scope.value = data