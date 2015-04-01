angular.module "ticketApp", [
	"ui.router"     #better than ngResource
	"ngCookies"
]


.run [
  '$state'
  '$cookies'
  '$rootScope'
  'Auth'
  (
    $state
    $cookies
    $rootScope
    Auth
  ) ->
    console.log 'app run'
    $rootScope.$on('$stateChangeStart', (e, toState, toParams, fromState, fromParams)->
      if toState.module is 'private' and !Auth.isLoggedIn()
        e.preventDefault();
        $state.go 'login'
    )
]