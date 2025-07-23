Feature: DummyJSON Products API Automation

Background:
  * url 'https://dummyjson.com'
  # * header Accept = 'application/json'

Scenario: Get All Products
  Given path 'products'
  When method get
  Then status 200
  And match response.products == '#notnull'
  And match response.total    == '#? _ >= 1'
  And match response.products[0].id == '#notnull'
  * print response

Scenario: Get Single Product by ID
  Given path 'products', 1
  When method get
  Then status 200
  And match response.id == 1
  * print response

Scenario: Search Products by Query
  Given path 'products/search'
  And param q = 'phone'
  When method get
  Then status 200
  And match response.products == '#notnull'
  And match response.total    == '#? _ >= 1'
  * print response

Scenario: Get Products with Limit and Skip
  Given path 'products'
  And param limit = 10
  And param skip  = 10
  When method get
  Then status 200
  And match response.limit == 10
  And match response.skip  == 10
  * print response

Scenario: Get Products with Selected Fields
  Given path 'products'
  And param limit  = 5
  And param select = 'title,price'
  When method get
  Then status 200
  And match response.products[0].title == '#notnull'
  And match response.products[0].price == '#notnull'
  * print response

Scenario: Get Products Sorted by Title ASC
  Given path 'products'
  And param sortBy = 'title'
  And param order  = 'asc'
  When method get
  Then status 200
  And match response.products[0].title == '#notnull'
  * print response

Scenario: Get All Product Categories
  Given path 'products/categories'
  When method get
  Then status 200
  And match response == '#[]'        // array valid
  And assert response.length > 0     // tidak kosong
  And match each response ==
    """
    { slug: '#string', name: '#string', url: '#string' }
    """

Scenario: Get Products by Category
  Given path 'products/category/smartphones'
  When method get
  Then status 200
  And match response.products[0].category == 'smartphones'
  * print response

# Untuk POST, simpan ID jika mau lanjut ke PUT & DELETE
Scenario: Add New Product
  Given path 'products/add'
  And request { title: 'BMW Pencil', price: 15.5, category: 'stationery' }
  When method post
  Then status 201
  And match response.id    == '#notnull'
  And match response.title == 'BMW Pencil'
  And match response.price == 15.5
  * def newId = response.id
  * print response

Scenario: Update Product Title
  Given path 'products', 1
  And request { title: 'iPhone Galaxy +1' }
  When method put
  Then status 200
  And match response.title == 'iPhone Galaxy +1'
  * print response

Scenario: Delete Product by ID
  Given path 'products', 1
  When method delete
  Then status 200
  And match response.isDeleted == true
  * print response
