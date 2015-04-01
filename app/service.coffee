angular.module "ticketApp"


.factory 'Users', ($http) ->
    getAll: (success, error) ->
      $http.get('/users').success(success).error error
    return


.factory 'TicketService', [
  '$http'
  'Config'
  (
    $http
    Config
  ) ->
    getAll: (handleSuccess, handleError)->
      $http.get("#{Config.api.object}/ticket")
      .success handleSuccess
      .error handleError

    get: (objectId, handleSuccess, handleError)->
      $http.get("#{Config.api.object}/ticket/#{objectId}")
      .success handleSuccess
      .error handleError

    create: (data, handleSuccess, handleError)->
      $http.post("#{Config.api.object}/ticket", data)
      .success handleSuccess
      .error handleError

    update: (objectId, data, handleSuccess, handleError)->
      $http.put("#{Config.api.object}/ticket/#{objectId}", data)
      .success handleSuccess
      .error handleError


]


.service 'Auth', [
  '$cookieStore'
  (
    $cookieStore
  ) ->
    @getToken = ->
      $cookieStore.get 'sessionToken'
    @setToken = (sessionToken)->
      $cookieStore.put 'sessionToken', sessionToken
    @removeToken = ->
      $cookieStore.remove 'sessionToken'
    @isLoggedIn = ->
      $cookieStore.get 'sessionToken'
    @getUser = ->
      $cookieStore.get 'user'
    @setUser = (user)->
      $cookieStore.put 'user', user
    return
]

#.factory "UserService", [
#  '$http'
#  'Config'
#  'Auth'
#  (
#    $http
#    Config
#    Auth
#  ) ->
#    register: (user, success, error) ->
#      $http.post("#{Config.api.user}/register", user)
#      .success((res) ->
#        success()
#      ).error error
#
#    login: (user, success, error) ->
#      $http.post("#{Config.api.user}/login", user)
#      .success (res) ->
#        Auth.setToken res.token
#        success(res)
#      .error error
#
#    logout: (user, success, error) ->
#      $http.get("#{Config.api.user}/logout")
#      .success (res)->
#        Auth.removeToken()
#        success()
#      .error error
#    return
#]



