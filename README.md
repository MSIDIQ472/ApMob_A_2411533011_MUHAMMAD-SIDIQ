# Aplikasi Keuangan

Aplikasi Flutter pencatat pemasukan dan pengeluaran dengan registrasi akun,
login, ringkasan saldo, riwayat transaksi, dan profil. Data akun dan transaksi
disimpan secara lokal menggunakan SQLite.

## Menjalankan aplikasi

Pastikan Flutter SDK terpasang, lalu jalankan:

```bash
flutter pub get
flutter run
```

## Pengujian

```bash
flutter test
```

## Membuat APK Android

```bash
flutter build apk --release
```

APK hasil build tersedia di `build/app/outputs/flutter-apk/app-release.apk`.
