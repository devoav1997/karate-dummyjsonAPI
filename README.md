# 🧪 DummyJSON API Karate BDD Test

## 🚀 Karate (BDD) API Automation for DummyJSON

Proyek ini adalah **automation testing** untuk [DummyJSON Auth API](https://dummyjson.com/docs/auth), [Users API](https://dummyjson.com/docs/users), [Products API](https://dummyjson.com/docs/products), [Carts API](https://dummyjson.com/docs/carts), **dan [Recipes API](https://dummyjson.com/docs/recipes)** menggunakan:

- **Karate** (Gherkin/BDD)
- **Maven** untuk build & running automation
- **Karate JUnit5** sebagai test runner

---

## 🗂️ Struktur Folder

```

karate-dummyjson/
├── pom.xml
└── src
└── test
├── java
│   └── dummyjson
│       ├── AuthRunner.java        # Karate Runner untuk Auth.feature
│       ├── UsersRunner.java       # Karate Runner untuk Users.feature
│       ├── ProductsRunner.java    # Karate Runner untuk Products.feature
│       ├── CartsRunner.java       # Karate Runner untuk Carts.feature
│       └── RecipesRunner.java     # Karate Runner untuk Recipes.feature
└── resources
└── dummyjson
├── Auth.feature           # Feature file BDD untuk Auth API
├── Users.feature          # Feature file BDD untuk Users API
├── Products.feature       # Feature file BDD untuk Products API
├── Carts.feature          # Feature file BDD untuk Carts API
└── Recipes.feature        # Feature file BDD untuk Recipes API

````

---

## ⚙️ Cara Menjalankan Automation

### 1. **Clone repositori**

```bash
git clone https://github.com/devoav1997/karate-dummyjsonAPI.git
cd karate-dummyjson
````

### 2. **Install Dependency (Maven)**

Pastikan sudah install **Java 17+** dan **Maven**.

```bash
# Cek versi Java (direkomendasikan 17 ke atas)
java -version

# Cek versi Maven
mvn -v
```

### 3. **Jalankan Semua Test**

```bash
mvn test
```

### 4. **Jalankan Satu Runner Saja**

```bash
# Jalankan Auth API tests
mvn test -Dtest=dummyjson.AuthRunner

# Jalankan Users API tests
mvn test -Dtest=dummyjson.UsersRunner

# Jalankan Products API tests
mvn test -Dtest=dummyjson.ProductsRunner

# Jalankan Carts API tests
mvn test -Dtest=dummyjson.CartsRunner

# Jalankan Recipes API tests
mvn test -Dtest=dummyjson.RecipesRunner
```

### 5. **Lihat Report HTML**

Setelah selesai menjalankan test, buka report hasil di:

```
target/karate-reports/karate-summary.html
```

---

## ✅ Skenario yang Diuji

### 1. **Auth API**

* Login dan Ambil Token
* Get Auth User Info (dengan Bearer token)
* Refresh Token
* Only Login (@loginOnly)

---

### 2. **Users API**

* Get All Users
* Get Single User by ID
* Login User & Get Token
* Get Current Authenticated User
* Search Users by Name
* Filter Users by Hair Color
* Get Users with Limit, Skip, Select
* Get Users Sorted by First Name ASC
* Get User's Carts/Posts/Todos by User ID
* Add New User
* Update User
* Delete User

---

### 3. **Products API**

* Get All Products
* Get Single Product by ID
* Search Products by Query
* Get Products with Limit and Skip
* Get Products with Selected Fields
* Get Products Sorted by Title ASC
* Get All Product Categories
* Get Products by Category
* Add New Product
* Update Product Title
* Delete Product by ID

---

### 4. **Carts API**

* Get All Carts
* Get Single Cart by ID
* Get Carts by User ID
* Add New Cart
* Update Cart (add product)
* Delete Cart

---

### 5. **Recipes API**

* Get All Recipes
* Get Single Recipe by ID
* Search Recipes by Query
* Get Recipes with Limit, Skip & Selected Fields
* Get Recipes Sorted by Name ASC
* Get All Recipes Tags
* Get Recipes by Tag
* Get Recipes by Meal Type
* Add New Recipe
* Update Recipe
* Delete Recipe

---

## 📝 Contoh Menjalankan dan Melihat Response

Agar response *rapi* di terminal, sudah otomatis di-*print* di setiap scenario dengan:

```gherkin
* print response
```

**Contoh output di terminal (Users):**

```json
15:24:01.581 [print] {
  "users": [
    { "id": 1, "firstName": "Emily", ... },
    { "id": 2, "firstName": "John", ... }
  ],
  "total": 100,
  ...
}
```

---

**Menjalankan dari terminal:**

```bash
mvn test -Dtest=dummyjson.AuthRunner
mvn test -Dtest=dummyjson.UsersRunner
mvn test -Dtest=dummyjson.ProductsRunner
mvn test -Dtest=dummyjson.CartsRunner
mvn test -Dtest=dummyjson.RecipesRunner
```

---

## 📦 Requirements

* Java 17 (`brew install openjdk@17` di Mac)
* Maven (`brew install maven` atau install manual)
* Koneksi internet (akses ke [https://dummyjson.com](https://dummyjson.com))

---

## 📚 Tools yang Digunakan

* **Karate** – Framework BDD API Testing (Given-When-Then, Gherkin syntax)
* **JUnit5** – Runner untuk Karate di Maven
* **Maven** – Build & dependency management

---

<details>
<summary>🔗 Referensi API DummyJSON</summary>

* [Auth API Docs](https://dummyjson.com/docs/auth)
* [Users API Docs](https://dummyjson.com/docs/users)
* [Products API Docs](https://dummyjson.com/docs/products)
* [Carts API Docs](https://dummyjson.com/docs/carts)
* [Recipes API Docs](https://dummyjson.com/docs/recipes)

</details>

---

