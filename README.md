# VTube 🎬

Aplikasi web streaming video berbasis Java Web (JSP/Servlet) yang memungkinkan pengguna untuk mengupload, menonton, dan berinteraksi dengan video secara online.

## 👥 Anggota Kelompok 5
| Nama | NIM |
|------|-----|
| Jonathan Gilbert Tjahja | 103012400092 |
| Fabian Aditya Rahman | 103012400082 |
| Satria Dinata | 103012400389 |
| Diwan Rizan Janadifa | 103012400315 |

## 📋 Deskripsi
VTube adalah platform streaming video yang dibangun menggunakan Java Web (JSP/Servlet) sebagai tugas besar mata kuliah Pemrograman Berorientasi Objek (PBO). Aplikasi ini memungkinkan pengguna untuk membuat akun, mengupload video, menonton video dari pengguna lain, serta berinteraksi melalui fitur like, komentar, dan subscribe.

## ✨ Fitur
- 🔐 Register & Login pengguna
- 📤 Upload video
- 🎥 Tonton video
- 👍 Like video
- 💬 Komentar video
- 🔔 Subscribe channel
- 🔖 Simpan video

## 🖥️ System Requirements
- Java JDK 11+
- Apache Tomcat 10.1+
- MySQL 8.0+
- NetBeans IDE 19+
- Browser (Chrome, Firefox, Edge)

## 🚀 Cara Menjalankan Lokal
1. Clone repository ini
```bash
   git clone https://github.com/JonathanGilbert17/Tubes_PBO_Kelompok5.git
```
2. Import database ke MySQL lokal
```bash
   mysql -u root -p vtube_db < vtube_db.sql
```
3. Buka project di NetBeans
4. Sesuaikan koneksi di `src/java/config/DBConnection.java`
```java
   private static final String URL = "jdbc:mysql://localhost:3306/vtube_db";
   private static final String USER = "root";
   private static final String PASSWORD = "";
```
5. Clean and Build project
6. Run project
