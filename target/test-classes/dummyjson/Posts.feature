Feature: DummyJSON Posts API Automation

Background:
  * url 'https://dummyjson.com'

# 1) Get all posts
Scenario: Get All Posts
  Given path 'posts'
  When method get
  Then status 200
  And match response.posts == '#notnull'
  And match response.total == '#? _ >= 1'
  And match response.posts[0].id == '#number'
  * print response

# 2) Get a single post
Scenario: Get Single Post by ID
  Given path 'posts', 1
  When method get
  Then status 200
  And match response.id == 1
  And match response.title == '#string'
  And match response.body == '#string'
  And match response.userId == '#number'
  And match response.reactions == { likes: '#number', dislikes: '#number' }
  * print response

# 3) Search posts
Scenario: Search Posts by Query
  Given path 'posts/search'
  And param q = 'love'
  When method get
  Then status 200
  And match response.total == '#? _ >= 1'
  # cek judul/badan mengandung 'love' (case-insensitive) setidaknya untuk item pertama
  * def t = response.posts.length > 0 ? (response.posts[0].title + ' ' + response.posts[0].body).toLowerCase() : ''
  * assert t.indexOf('love') > -1
  * print response

# 4) Limit, skip, select
Scenario: Get Posts with Limit, Skip & Selected Fields
  Given path 'posts'
  And param limit = 10
  And param skip  = 10
  And param select = 'title,reactions,userId'
  When method get
  Then status 200
  And match response.limit == 10
  And match response.skip  == 10
  And match response.posts[0].title == '#string'
  And match response.posts[0].reactions == { likes: '#number', dislikes: '#number' }
  And match response.posts[0].userId == '#number'
  * print response

# 5) Sort posts
Scenario: Get Posts Sorted by Title ASC
  Given path 'posts'
  And param sortBy = 'title'
  And param order  = 'asc'
  When method get
  Then status 200
  And match response.posts[0].title == '#string'
  * print response

# 6) Get all posts tags (objects)
Scenario: Get All Posts Tags (objects)
  Given path 'posts/tags'
  When method get
  Then status 200
  And match response == '#[]'
  And match each response ==
    """
    { slug: '#string', name: '#string', url: '#string' }
    """
  * print response

# 7) Get posts tag list (strings)
Scenario: Get Posts Tag List (strings)
  Given path 'posts/tag-list'
  When method get
  Then status 200
  And match response == '#[]'
  And match each response == '#string'
  * print response

# 8) Get posts by a tag
Scenario: Get Posts by Tag 'life'
  Given path 'posts/tag/life'
  When method get
  Then status 200
  And match response.total == '#? _ >= 0'
  # Semua posts harus punya tag 'life' jika ada isinya
  And match each response.posts[*].tags contains 'life'
  * print response

# 9) Get all posts by user id
Scenario: Get All Posts by User ID
  Given path 'posts/user', 5
  When method get
  Then status 200
  And match response.total == '#? _ >= 0'
  And match each response.posts[*].userId == 5
  * print response

# 10) Get post's comments
Scenario: Get Post Comments by Post ID
  Given path 'posts', 1, 'comments'
  When method get
  Then status 200
  And match response.total == '#? _ >= 0'
  And match response.comments == '#[]'
  And match each response.comments ==
    """
    {
      id:    '#number',
      body:  '#string',
      postId: 1,
      likes: '#number',
      user: { id: '#number', username: '#string', fullName: '#string' }
    }
    """
  * print response

# 11) Add a new post
Scenario: Add New Post
  Given path 'posts/add'
  And request
    """
    {
      "title": "I am in love with someone.",
      "userId": 5
    }
    """
  When method post
  Then status 201
  And match response.id == '#number'
  And match response.title == 'I am in love with someone.'
  And match response.userId == 5
  * print response

# 12) Update a post (title only)
Scenario: Update Post Title
  Given path 'posts', 1
  And request { title: 'I think I should shift to the moon' }
  When method put
  Then status 200
  And match response.id == 1
  And match response.title == 'I think I should shift to the moon'
  * print response

# 13) Delete a post
Scenario: Delete Post by ID
  Given path 'posts', 1
  When method delete
  Then status 200
  And match response.id == 1
  # Field opsional: validasi hanya jika ada
  * eval if (typeof response.isDeleted !== 'undefined') { karate.match(response.isDeleted, true); }
  * eval if (typeof response.deletedOn !== 'undefined') { karate.match(response.deletedOn, '#string'); }
  * print response
