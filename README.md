# 🧪 DummyJSON API Karate BDD Test

## 🚀 Karate (BDD) API Automation for DummyJSON

Proyek ini adalah **automation testing** untuk [DummyJSON Auth API](https://dummyjson.com/docs/auth) menggunakan:

* **Karate** (Gherkin/BDD)
* **Maven** untuk build dan menjalankan automation
* **Karate JUnit5** untuk runner test

---

## 🗂️ Struktur Folder

\`\`\`
karate-dummyjson/
├── pom.xml
└── src
    └── test
        ├── java
        │   └── dummyjson
        │       └── AuthRunner.java       # Karate Runner untuk Auth.feature
        └── resources
            └── dummyjson
                └── Auth.feature          # Feature file BDD untuk Auth API
\`\`\`

---

## ⚙️ Cara Menjalankan Automation

### 1. **Clone repositori**

\`\`\`bash
git clone https://github.com/username/karate-dummyjson.git
cd karate-dummyjson
\`\`\`

### 2. **Install Dependency (Maven)**

Pastikan sudah install **Java 17+** dan **Maven**.

\`\`\`bash
# Cek versi Java (disarankan 17)
java -version

# Cek versi Maven
mvn -v
\`\`\`

### 3. **Jalankan Semua Test**

\`\`\`bash
mvn test
\`\`\`

### 4. **Jalankan Satu Runner Saja**

\`\`\`bash
mvn test -Dtest=dummyjson.AuthRunner
\`\`\`

### 5. **Lihat Report HTML**

Setelah selesai, buka report hasil test di:
\`\`\`
target/karate-reports/karate-summary.html
\`\`\`

---

## ✅ Skenario yang Diuji

### 1. **Login dan Ambil Token**

- Kirim request login ke endpoint \`/auth/login\` dengan username & password.
- Pastikan response mengandung **accessToken** & **refreshToken**.

### 2. **Get Auth User Info (dengan Bearer token)**

- Kirim request ke \`/auth/me\` menggunakan accessToken dari hasil login.
- Pastikan response mengandung username sesuai login.

### 3. **Refresh Token**

- Kirim request ke \`/auth/refresh\` dengan refreshToken yang valid.
- Pastikan mendapat accessToken & refreshToken baru.

### 4. **Only Login (@loginOnly)**

- Step login yang reusable untuk scenario lain (dengan tag \`@loginOnly\`).

---

## 📝 Contoh Menjalankan dan Melihat Response

**Agar response terlihat rapih di terminal, sudah otomatis di-print di setiap scenario dengan:**
\`\`\`gherkin
* print response
\`\`\`
Contoh output di terminal:
\`\`\`json
15:22:34.370 [print] {
  "accessToken": "...",
  "refreshToken": "...",
  "id": 1,
  "username": "emilys",
  ...
}
\`\`\`

**Menjalankan dari terminal:**
\`\`\`bash
mvn test -Dtest=dummyjson.AuthRunner
\`\`\`

---

## 📦 Requirements

* Java 17 (\`brew install openjdk@17\` di Mac)
* Maven (\`brew install maven\` atau install manual)
* Koneksi internet (akses ke https://dummyjson.com)

---

## 📚 Tools yang Digunakan

* **Karate** – Framework BDD API Testing (Given-When-Then, Gherkin syntax)
* **JUnit5** – Runner untuk Karate di Maven
* **Maven** – Build & dependency management



