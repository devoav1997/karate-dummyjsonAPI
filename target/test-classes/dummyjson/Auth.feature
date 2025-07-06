Feature: DummyJSON Auth API Automation

  Background:
    * url 'https://dummyjson.com'
    * def credentials = { username: 'emilys', password: 'emilyspass' }
    * def token = null
    * def refreshToken = null

  Scenario: Login and get tokens
    Given path 'auth/login'
    And request credentials
    When method post
    Then status 200
    And match response.accessToken != null
    And match response.refreshToken != null
    * def token = response.accessToken
    * def refreshToken = response.refreshToken
    * print response

  Scenario: Get Auth User Info (with Bearer token)
    * def loginResponse =
      """
      function(){ 
        var res = karate.callSingle('classpath:dummyjson/Auth.feature@loginOnly', {}); 
        return res.response;
      }
      """
    * def token = loginResponse().accessToken
    Given path 'auth/me'
    And header Authorization = 'Bearer ' + token
    When method get
    Then status 200
    And match response.username == 'emilys'
    * print response

  Scenario: Refresh Token
    * def loginResponse =
      """
      function(){ 
        var res = karate.callSingle('classpath:dummyjson/Auth.feature@loginOnly', {}); 
        return res.response;
      }
      """
    * def refreshToken = loginResponse().refreshToken
    Given path 'auth/refresh'
    And request { refreshToken: '#(refreshToken)' }
    When method post
    Then status 200
    And match response.accessToken != null
    And match response.refreshToken != null
    * print response

  @loginOnly
  Scenario: Only Login
    Given path 'auth/login'
    And request credentials
    When method post
    Then status 200
    * print response
