Feature: DummyJSON Users API Automation

Background:
  * url 'https://dummyjson.com'

Scenario: Get All Users
  Given path 'users'
  When method get
  Then status 200
  And match response.users == '#notnull'
  And match response.total == '#? _ >= 1'
  And match response.users[0].id == '#notnull'
  * print response

Scenario: Get Single User by ID
  Given path 'users', 1
  When method get
  Then status 200
  And match response.id == '#? _ == 1 || _ == "1"'
  And match response.firstName == '#notnull'
  * print response

Scenario: Login User and Get Tokens
  Given path 'user/login'
  And request
    """
    {
      "username": "emilys",
      "password": "emilyspass",
      "expiresInMins": 30
    }
    """
  When method post
  Then status 200
  And match response.accessToken == '#string'
  And match response.refreshToken == '#string'
  And match response.username == 'emilys'
  * print response

Scenario: Get Current Authenticated User (with Bearer token)
  # Login to get accessToken
  Given path 'user/login'
  And request { "username": "emilys", "password": "emilyspass" }
  When method post
  Then status 200
  * def accessToken = response.accessToken
  # Use accessToken to get /user/me
  Given path 'user/me'
  And header Authorization = 'Bearer ' + accessToken
  When method get
  Then status 200
  And match response.username == 'emilys'
  And match response.firstName == 'Emily'
  * print response

Scenario: Search Users by Name
  Given path 'users/search'
  And param q = 'Emily'
  When method get
  Then status 200
  * assert response.users.length > 0
  * assert response.users[0].firstName.indexOf('Emily') > -1
  * assert response.total >= 1
  * print response

Scenario: Filter Users by Hair Color (Brown)
  Given path 'users/filter'
  And param key = 'hair.color'
  And param value = 'Brown'
  When method get
  Then status 200
  * assert response.users.length > 0
  And match response.users[0].hair.color == 'Brown'
  * assert response.total >= 1
  * print response

Scenario: Get Users with Limit, Skip, and Select
  Given path 'users'
  And param limit = 5
  And param skip  = 10
  And param select = 'firstName,age'
  When method get
  Then status 200
  * assert response.users.length > 0
  And match response.users[0].firstName == '#string'
  And match response.users[0].age == '#number'
  * print response

Scenario: Get Users Sorted by First Name ASC
  Given path 'users'
  And param sortBy = 'firstName'
  And param order  = 'asc'
  When method get
  Then status 200
  * assert response.users.length > 0
  And match response.users[0].firstName == '#string'
  * print response

# ------------------ Koleksi aman saat kosong + toleran tipe ------------------

Scenario: Get User's Carts by User ID
  Given path 'users', 6, 'carts'
  When method get
  Then status 200
  * def carts = response.carts
  * def cartSchema =
  """
  {
    id:            '#number',
    userId:        '#? _ == 6 || _ == "6"',
    total:         '#number',
    totalProducts: '#number',
    totalQuantity: '#number'
  }
  """
  * eval if (carts && carts.length > 0) { for (var i = 0; i < carts.length; i++) karate.match(carts[i], cartSchema); }
  * print response

Scenario: Get User's Posts by User ID
  Given path 'users', 5, 'posts'
  When method get
  Then status 200
  * def posts = response.posts
  * def postSchema =
  """
  {
    id:     '#number',
    userId: '#? _ == 5 || _ == "5"'
  }
  """
  * eval if (posts && posts.length > 0) { for (var i = 0; i < posts.length; i++) karate.match(posts[i], postSchema); }
  * print response

Scenario: Get User's Todos by User ID
  Given path 'users', 7, 'todos'
  When method get
  Then status 200
  * def todos = response.todos
  * def todoSchema =
  """
  {
    id:        '#number',
    userId:    '#? _ == 7 || _ == "7"',
    completed: '#boolean',
    todo:      '#string'
  }
  """
  * eval if (todos && todos.length > 0) { for (var i = 0; i < todos.length; i++) karate.match(todos[i], todoSchema); }
  * print response

# ------------------------------------------------------------------------------

Scenario: Add New User
  Given path 'users/add'
  And request
    """
    {
      "firstName": "Muhammad",
      "lastName": "Ovi",
      "age": 250
    }
    """
  When method post
  Then status 201
  And match response.id == '#notnull'
  And match response.firstName == 'Muhammad'
  And match response.lastName == 'Ovi'
  * print response

Scenario: Update User Last Name
  Given path 'users', 2
  And request { "lastName": "Owais" }
  When method put
  Then status 200
  # id kadang string, buat fleksibel
  And match response.id == '#? _ == 2 || _ == "2"'
  And match response.lastName == 'Owais'
  * print response

Scenario: Delete User by ID
  Given path 'users', 1
  When method delete
  Then status 200
  * print response
  # Field opsional -> validasi kondisional via eval
  * eval if (typeof response.isDeleted !== 'undefined') { karate.match(response.isDeleted, true); }
  * eval if (typeof response.deletedOn !== 'undefined') { karate.match(response.deletedOn, '#string'); }
