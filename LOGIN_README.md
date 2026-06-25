# Gridova - Login Page

Halaman login untuk aplikasi Gridova telah dibuat sesuai design.

## Fitur Login Page

✅ Design modern dengan gradient background
✅ Input field untuk Email/Nomor HP
✅ Input field untuk Password dengan toggle visibility
✅ Checkbox "Ingat saya"
✅ Link "Lupa kata sandi?"
✅ Tombol login utama
✅ Opsi login dengan Google dan Nomor HP
✅ Link untuk daftar akun baru
✅ Responsive design
✅ Logo Gridova dengan icon listrik

## Cara Menjalankan Aplikasi

### Mode Web Server (Tanpa membuka Chrome otomatis)

```bash
flutter run -d web-server --web-port=8080
```

Kemudian buka browser dan akses:

```
http://localhost:8080
```

### Atau dengan port default:

```bash
flutter run -d web-server
```

Aplikasi akan menampilkan URL yang bisa dibuka di browser pilihan Anda.

## Struktur Project

```
lib/
  ├── main.dart              # Entry point aplikasi
  └── screens/
      └── login_page.dart    # Halaman login
```

## Catatan

- Background illustration bersifat opsional. Jika ingin menambahkan, letakkan gambar di `assets/images/house_illustration.png`
- Warna utama aplikasi: `#4A7CFF` (biru)
- Font yang digunakan: SF Pro Display (fallback ke system default)
