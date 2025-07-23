
# 🧪 DummyJSON API Karate BDD Test

## 🚀 Karate (BDD) API Automation for DummyJSON

Proyek ini adalah **automation testing** untuk [DummyJSON Auth API](https://dummyjson.com/docs/auth) **dan [Products API](https://dummyjson.com/docs/products)** menggunakan:

* **Karate** (Gherkin/BDD)
* **Maven** untuk build dan menjalankan automation
* **Karate JUnit5** untuk runner test

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
        │       └── ProductsRunner.java    # Karate Runner untuk Products.feature
        └── resources
            └── dummyjson
                ├── Auth.feature           # Feature file BDD untuk Auth API
                └── Products.feature       # Feature file BDD untuk Products API
```

---

## ⚙️ Cara Menjalankan Automation

### 1. **Clone repositori**

```bash
git clone https://github.com/devoav1997/karate-dummyjsonAPI.git
cd karate-dummyjson
```

### 2. **Install Dependency (Maven)**

Pastikan sudah install **Java 17+** dan **Maven**.

```bash
# Cek versi Java (disarankan 17)
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

# Jalankan Products API tests
mvn test -Dtest=dummyjson.ProductsRunner
```

### 5. **Lihat Report HTML**

Setelah selesai, buka report hasil test di:

```
target/karate-reports/karate-summary.html
```

---

## ✅ Skenario yang Diuji

### 1. **Auth API**

* **Login dan Ambil Token**

  * Kirim request login ke endpoint `/auth/login` dengan username & password.
  * Pastikan response mengandung **accessToken** & **refreshToken**.

* **Get Auth User Info (dengan Bearer token)**

  * Kirim request ke `/auth/me` menggunakan accessToken dari hasil login.
  * Pastikan response mengandung username sesuai login.

* **Refresh Token**

  * Kirim request ke `/auth/refresh` dengan refreshToken yang valid.
  * Pastikan mendapat accessToken & refreshToken baru.

* **Only Login (@loginOnly)**

  * Step login yang reusable untuk scenario lain (dengan tag `@loginOnly`).

---

### 2. **Products API**

* **Get All Products**

  * Kirim request ke `/products`.
  * Pastikan response list produk tidak kosong & ada field kunci.

* **Get Single Product by ID**

  * Kirim request ke `/products/{id}`.
  * Pastikan response sesuai dengan ID produk.

* **Search Products by Query**

  * Kirim request ke `/products/search?q=...` untuk pencarian produk.
  * Pastikan response produk relevan & tidak kosong.

* **Get Products with Limit and Skip**

  * Kirim request ke `/products?limit=10&skip=10`.
  * Cek field `limit` & `skip` pada response.

* **Get Products with Selected Fields**

  * Kirim request ke `/products?limit=5&select=title,price`.
  * Cek hanya field `title` dan `price` yang muncul.

* **Get Products Sorted by Title ASC**

  * Kirim request ke `/products?sortBy=title&order=asc`.
  * Cek sorting produk berdasarkan title.

* **Get All Product Categories**

  * Kirim request ke `/products/categories`.
  * Pastikan response array berisi kategori valid.

* **Get Products by Category**

  * Kirim request ke `/products/category/{nama_kategori}`.
  * Pastikan produk termasuk dalam kategori sesuai.

* **Add New Product**

  * Kirim request ke `/products/add` (POST) dengan payload produk baru.
  * Cek response berisi data produk baru.

* **Update Product Title**

  * Kirim request ke `/products/{id}` (PUT) untuk update data produk.
  * Cek response field title sudah berubah.

* **Delete Product by ID**

  * Kirim request ke `/products/{id}` (DELETE).
  * Cek response `isDeleted` = true.

---

## 📝 Contoh Menjalankan dan Melihat Response

**Agar response terlihat rapih di terminal, sudah otomatis di-print di setiap scenario dengan:**

```gherkin
* print response
```

Contoh output di terminal (Auth):

```json
15:22:34.370 [print] {
  "accessToken": "...",
  "refreshToken": "...",
  "id": 1,
  "username": "emilys",
  ...
}
```

Contoh output di terminal (Products):

```json
15:24:01.581 [print] {
  "products": [
    { "id": 1, "title": "iPhone 9", ... },
    { "id": 2, "title": "Samsung Galaxy", ... }
  ],
  "total": 100,
  ...
}
```

**Menjalankan dari terminal:**

```bash
mvn test -Dtest=dummyjson.AuthRunner
mvn test -Dtest=dummyjson.ProductsRunner
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

