angular.module "ticketApp"

.controller "LoginCtrl", [
  '$scope'
  '$rootScope'
  'Auth'
  '$state'
  (
    $scope
    $rootScope
    Auth
    $state
  ) ->
    $scope.login = ->
      Auth.setToken 'thisIsAToken'
      Auth.setUser $scope.user
      $state.go('tickets')

]
.controller "LogoutCtrl", [
  '$scope'
  '$rootScope'
  'Auth'
  '$state'
  (
    $scope
    $rootScope
    Auth
    $state
  ) ->

    $scope.logout = ->
      Auth.removeToken 'thisIsAToken'
      Auth.setUser $scope.user
      $state.go('tickets')

]


.controller "TicketsCtrl", [
  '$scope'
  '$rootScope'
  'TicketService'
  (
    $scope
    $rootScope
    TicketService
  ) ->

    TicketService.getAll(
      (res)->
        $scope.tickets = res.results
        console.log $scope.tickets
      (err)->
        $rootScope.error = err
        console.log err
    )

]


.controller "TicketViewCtrl", [
  '$scope'
  '$rootScope'
  'TicketService'
  '$stateParams'
  'Auth'
  (
    $scope
    $rootScope
    TicketService
    $stateParams
    Auth
  ) ->
    TicketService.get($stateParams.objectId,
      (res)->
        $scope.ticket =res
        console.log $scope.ticket
      (err)->
        $rootScope.error = err
    )


    $scope.addReply = ()->
#      add attr, default to be set by server
      $scope.newReply.user = Auth.getUser()
      $scope.newReply.time = new Date()

      $scope.ticket.replys = $scope.ticket.replys or []
      $scope.ticket.replys.push($scope.newReply)
      updateDate = {
        replys: $scope.ticket.replys
        state: '已回复'
      }
      TicketService.update($scope.ticket.objectId, updateDate,
        (res)->
#          window.location.reload()
        (err)->
          $rootScope.error = err
      )

]


.controller "TicketNewCtrl", [
  '$scope'
  '$rootScope'
  '$state'
  'TicketService'
  'Auth'
  (
    $scope
    $rootScope
    $state
    TicketService
    Auth
  ) ->
    $scope.ticket = {}

    $scope.newTicket = ->
#      add attr, default to be set by server
      $scope.ticket.state = '未回复'
      $scope.ticket.user = Auth.getUser()
      console.log $scope.ticket

      TicketService.create($scope.ticket,
        (res)->
          $state.go("tickets")
        (err)->
          $rootScope.error = err
      )

]
