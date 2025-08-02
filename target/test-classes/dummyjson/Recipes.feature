Feature: DummyJSON Recipes API Automation

Background:
  * url 'https://dummyjson.com'

Scenario: Get All Recipes
  Given path 'recipes'
  When method get
  Then status 200
  And match response.recipes == '#notnull'
  And match response.total == '#? _ >= 1'
  And match response.recipes[0].id == '#notnull'
  * print response

Scenario: Get Single Recipe by ID
  Given path 'recipes', 1
  When method get
  Then status 200
  And match response.id == 1
  And match response.name == '#notnull'
  And match response.ingredients == '#array'
  * print response

Scenario: Search Recipes by Query
  Given path 'recipes/search'
  And param q = 'Margherita'
  When method get
  Then status 200
  And match response.recipes[0].name contains 'Margherita'
  And assert response.total >= 1
  * print response

Scenario: Get Recipes with Limit, Skip & Selected Fields
  Given path 'recipes'
  And param limit = 10
  And param skip = 10
  And param select = 'name,image'
  When method get
  Then status 200
  And match response.recipes[0].name == '#notnull'
  And match response.recipes[0].image == '#string'
  * print response

Scenario: Get Recipes Sorted by Name ASC
  Given path 'recipes'
  And param sortBy = 'name'
  And param order = 'asc'
  When method get
  Then status 200
  And match response.recipes[0].name == '#notnull'
  * print response

Scenario: Get All Recipes Tags
  Given path 'recipes/tags'
  When method get
  Then status 200
  And match response == '#array'
  And assert response.length > 0
  * print response

Scenario: Get Recipes by Tag
  Given path 'recipes/tag', 'Pakistani'
  When method get
  Then status 200
  And match response.recipes[0].tags contains 'Pakistani'
  * print response

Scenario: Get Recipes by Meal Type
  Given path 'recipes/meal-type', 'snack'
  When method get
  Then status 200
  And match response.recipes[0].mealType contains 'Snack'
  * print response

Scenario: Add New Recipe
  Given path 'recipes/add'
  And request
    """
    {
      "name": "Tasty Pizza",
      "ingredients": ["Dough", "Cheese"],
      "instructions": ["Mix", "Bake"],
      "prepTimeMinutes": 10,
      "cookTimeMinutes": 20,
      "servings": 2,
      "difficulty": "Easy",
      "cuisine": "Italian"
    }
    """
  When method post
  Then status 200             # Fix: POST /recipes/add return 200 (bukan 201)
  And match response.id == '#notnull'
  And match response.name == 'Tasty Pizza'
  * print response

Scenario: Update Recipe
  Given path 'recipes', 1
  And request { "name": "Tasty Pizza" }
  When method put
  Then status 200
  And match response.id == 1
  And match response.name == 'Tasty Pizza'
  * print response

Scenario: Delete Recipe
  Given path 'recipes', 1
  When method delete
  Then status 200
  And match response.isDeleted == true
  And match response.deletedOn == '#string'
  * print response
