Feature: DummyJSON Carts API Automation

Background:
  * url 'https://dummyjson.com'

Scenario: Get All Carts
  Given path 'carts'
  When method get
  Then status 200
  And match response.carts == '#notnull'
  And match response.total == '#? _ >= 1'
  And match response.carts[0].id == '#notnull'
  * print response

Scenario: Get Single Cart by ID
  Given path 'carts', 1
  When method get
  Then status 200
  And match response.id == 1
  And match response.products == '#notnull'
  * print response

Scenario: Get Carts by User ID
  Given path 'carts/user', 142
  When method get
  Then status 200
  And assert response.carts.length > 0
  And match each response.carts[*].userId == 142
  * print response


Scenario: Add New Cart
  Given path 'carts/add'
  And request
    """
    {
      "userId": 1,
      "products": [
        { "id": 144, "quantity": 4 },
        { "id": 98, "quantity": 1 }
      ]
    }
    """
  When method post
  Then status 201     
  And match response.id == '#notnull'
  And match response.userId == 1
  And match response.totalProducts == 2
  And match response.products[0].id == 98
  And match response.products[1].id == 144
  * print response

Scenario: Update Cart (add product)
  Given path 'carts', 1
  And request
    """
    {
      "merge": true,
      "products": [
        { "id": 1, "quantity": 1 }
      ]
    }
    """
  When method put
  Then status 200
  And match response.id == 1
  And match response.products[?(@.id==1)].quantity == [1]
  * print response

Scenario: Delete Cart
  Given path 'carts', 1
  When method delete
  Then status 200
  And match response.isDeleted == true
  And match response.deletedOn == '#string'
  * print response
