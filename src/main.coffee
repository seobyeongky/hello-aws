angular.module('test',['btford.socket-io'])
	.factory 'mySocket', (socketFactory) ->
		socketFactory()
	.controller 'MainCtrl', ($scope,mySocket) ->
		$scope.value = {}
		$scope.text = '{}'
		mySocket.on 'news', (data) ->
			$scope.value = data
		mySocket.on 'text', (data) ->
			$scope.text = data
		$scope.update = (text) ->
			mySocket.emit 'text', text