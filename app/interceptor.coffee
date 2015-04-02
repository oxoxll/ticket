angular.module "ticketApp"

.factory 'requestInterceptor', [
  '$q'
  'Auth'
  'Config'
  (
    $q
    Auth
    Config
  ) ->
    request: (request) ->
      request.headers = request.headers or {}
      if Auth.isLoggedIn()
#        Leancloud app Id & Key
        request.headers["X-AVOSCloud-Application-Id"] = Config.Leancloud.Id
        request.headers["X-AVOSCloud-Application-Key"] = Config.Leancloud.Key
        request.headers.Authorization = Auth.getToken()
      request

    response: (response) ->
      response or $q.when(response)

    responseError: (response) ->
      if response.status is 401 or response.status is 403
        console.log 'please login'
#        Auth.logout()
      $q.reject response
]

.config [
  '$httpProvider'
  (
    $httpProvider
  ) ->
    $httpProvider.interceptors.push 'requestInterceptor'
]
