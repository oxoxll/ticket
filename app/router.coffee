angular.module "ticketApp"

.config [
  "$stateProvider"
  (
    $stateProvider
  ) ->
    $stateProvider

#    ticket route
    .state "login",
      url: '/login'
      templateUrl: "views/login.html"
      controller: "LoginCtrl"
      module: 'public'

    .state "tickets",
      url: '/tickets'
      templateUrl: "views/tickets.html"
      controller: "TicketsCtrl"
      module: 'private'

    .state "ticketView",
      url: "/ticket/:objectId/view"
      templateUrl: "views/ticketView.html"
      controller: "TicketViewCtrl"
      module: 'private'

    .state "ticketNew",
      url: '/ticket/new'
      templateUrl: "views/ticketNew.html"
      controller: "TicketNewCtrl"
      module: 'private'

#    .otherwise redirectTo: "/"

]
