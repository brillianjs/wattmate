# ⚡ WattMate - Monitoring Listrik Cerdas

<div align="center">

![WattMate Logo](https://img.shields.io/badge/WattMate-Monitoring%20Listrik-blue?style=for-the-badge&logo=lightning)

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Material Design](https://img.shields.io/badge/Material%20Design-757575?style=for-the-badge&logo=material-design&logoColor=white)](https://material.io)

**Aplikasi monitoring penggunaan listrik modern dan responsif**

[🚀 Demo](#demo) • [📱 Features](#features) • [🛠️ Installation](#installation) • [📖 Usage](#usage)

</div>

---

## 📋 Deskripsi

**WattMate** adalah aplikasi monitoring listrik cerdas yang membantu Anda mengontrol dan mengoptimalkan penggunaan energi listrik di rumah atau kantor. Dengan interface yang modern dan user-friendly, WattMate memberikan insight mendalam tentang pola konsumsi listrik Anda.

## ✨ Features

### 🏠 **Dashboard Utama**

- **Quick Stats** - Lihat konsumsi hari ini dan biaya bulanan secara real-time
- **Navigation Menu** - Akses mudah ke semua fitur utama
- **Welcome Card** - Antarmuka yang ramah pengguna

### ⚡ **Monitoring Real-time**

- 📊 **Live Charts** - Grafik konsumsi daya dan tegangan real-time
- 📈 **Metrics Cards** - Data konsumsi, tegangan, arus, dan daya aktual
- 🔄 **Auto Update** - Data ter-update setiap detik
- 🟢 **Status Koneksi** - Indikator status perangkat monitoring

### 📈 **Riwayat Penggunaan**

- **📊 Tab Grafik**
  - Bar chart konsumsi harian/mingguan/bulanan
  - Summary cards dengan statistik lengkap
  - Trend analysis dan perbandingan periode
- **📝 Tab Detail**
  - Statistik penggunaan bulanan
  - List penggunaan harian dengan detail
  - Rekomendasi hemat energi personal

### 📑 **Laporan Bulanan**

- **📄 Tab Ringkasan**
  - Month/year selector
  - Key metrics dengan perbandingan bulan sebelumnya
  - Pie chart penggunaan per perangkat
  - Cost breakdown dan environmental impact
- **🔍 Tab Detail**
  - Detail penggunaan per perangkat
  - Daily usage pattern dengan line chart
  - Efficiency analysis dan optimization tips
- **📊 Tab Perbandingan**
  - Monthly comparison bar chart
  - Yearly trend analysis
  - Performance metrics dan cost analysis

### ⚙️ **Pengaturan Lengkap**

- **👤 Profile Management** - Edit profil dan informasi akun
- **🔔 Notifikasi**
  - Laporan harian dan mingguan
  - Peringatan batas konsumsi
  - Pengaturan custom alerts
- **🎨 Tampilan**
  - Dark/Light mode
  - Multi-language support (ID, EN, ES)
  - Custom units (kWh, MWh, GWh)
  - Multi-currency (IDR, USD, EUR)
- **💾 Data & Backup**
  - Auto backup ke cloud
  - Export data ke CSV
  - Reset data dengan konfirmasi
- **ℹ️ About & Support**
  - Help & FAQ
  - Privacy policy
  - App information

### 🔐 **Autentikasi**

- **🎨 Modern Login** - Gradient design dengan animasi smooth
- **✅ Form Validation** - Validasi input real-time
- **🔄 Loading States** - Loading indicator yang responsif
- **🚀 Auto Navigation** - Redirect otomatis ke dashboard

## 🛠️ Tech Stack

| Technology            | Purpose                         |
| --------------------- | ------------------------------- |
| **Flutter**           | Cross-platform mobile framework |
| **Dart**              | Programming language            |
| **Material Design 3** | UI/UX design system             |
| **fl_chart**          | Data visualization & charts     |
| **device_preview**    | Multi-device testing            |

## 📱 Screenshots

### Login & Dashboard

| Login Screen                                 | Dashboard                        | Real-time Monitoring    |
| -------------------------------------------- | -------------------------------- | ----------------------- |
| Modern gradient login with WattMate branding | Clean dashboard with quick stats | Live charts and metrics |

### Analytics & Reports

| Usage History               | Monthly Reports                | Settings                   |
| --------------------------- | ------------------------------ | -------------------------- |
| Historical data with trends | Comprehensive monthly analysis | Complete app configuration |

## 🚀 Installation

### Prerequisites

- **Flutter SDK** (>=3.8.1)
- **Dart SDK** (>=3.8.1)
- **Android Studio** / **VS Code** dengan Flutter extension
- **Android SDK** (untuk Android development)
- **Xcode** (untuk iOS development - macOS only)

### Quick Start

1. **Clone Repository**

   ```bash
   git clone https://github.com/your-username/monitoring_listrik.git
   cd monitoring_listrik
   ```

2. **Install Dependencies**

   ```bash
   flutter pub get
   ```

3. **Run Application**

   ```bash
   # Debug mode
   flutter run --debug

   # Release mode
   flutter run --release

   # Specific device
   flutter run -d chrome        # Web
   flutter run -d macos         # macOS
   flutter run -d <device-id>   # Specific mobile device
   ```

4. **Build for Production**

   ```bash
   # Android APK
   flutter build apk --release

   # Android App Bundle
   flutter build appbundle --release

   # iOS
   flutter build ios --release

   # Web
   flutter build web --release
   ```

## 📖 Usage

### 🎯 Getting Started

1. **Login** - Masukkan kredensial apa saja untuk demo
2. **Dashboard** - Lihat overview konsumsi listrik hari ini
3. **Explore Features** - Navigasi ke berbagai menu monitoring

### 🔄 Device Preview

Aplikasi dilengkapi dengan **Device Preview** untuk testing multi-device:

```bash
flutter run --debug
# Pilih Chrome untuk akses device preview
```

### 📊 Sample Data

Aplikasi menggunakan data simulasi realistis untuk demo:

- Real-time data yang ter-update setiap detik
- Historical data 12 bulan terakhir
- Various device usage patterns
- Cost calculations dan environmental impact

## 🎨 Design Philosophy

### 🌈 **Color Scheme**

- **Primary**: Blue shades (#1E3A8A, #3B82F6)
- **Accent**: Complementary colors (Green, Orange, Purple)
- **Background**: Gradient transitions untuk depth
- **Text**: High contrast untuk readability

### 📐 **Layout Principles**

- **Responsive Design** - Optimal di berbagai ukuran layar
- **Consistent Spacing** - 8dp grid system
- **Visual Hierarchy** - Clear information structure
- **Accessibility** - WCAG compliant colors dan typography

## 🏗️ Project Structure

```
lib/
├── main.dart                          # App entry point
├── screens/                           # All app screens
│   ├── login_page.dart               # Authentication screen
│   ├── dashboard_page.dart           # Main dashboard
│   ├── monitoring_realtime_page.dart # Real-time monitoring
│   ├── riwayat_penggunaan_page.dart  # Usage history
│   ├── laporan_bulanan_page.dart     # Monthly reports
│   └── pengaturan_page.dart          # Settings & configuration
└── widgets/                          # Reusable widgets
    └── wattmate_logo.dart            # Custom logo widget

assets/
└── images/                           # App assets
    ├── wattmate_logo.svg             # Logo vector
    └── logo_placeholder.txt          # Asset placeholder
```

## 🔧 Configuration

### 📱 Device Preview Setup

```dart
// main.dart
DevicePreview(
  enabled: !kReleaseMode,
  builder: (context) => const MyApp(),
)
```

### 🎨 Theme Configuration

```dart
// Material Design 3 theme
ColorScheme.fromSeed(
  seedColor: const Color(0xFF1E3A8A),
  brightness: Brightness.light,
)
```

## 🤝 Contributing

Kontribusi sangat diterima! Silakan:

1. **Fork** project ini
2. **Create** feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** ke branch (`git push origin feature/AmazingFeature`)
5. **Open** Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

## 👥 Contact

**Developer**: Your Name

- 📧 **Email**: your.email@domain.com
- 🐙 **GitHub**: [@your-username](https://github.com/your-username)
- 💼 **LinkedIn**: [Your Profile](https://linkedin.com/in/your-profile)

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev) - Amazing framework
- [Material Design](https://material.io) - Design system
- [fl_chart](https://pub.dev/packages/fl_chart) - Chart library
- [device_preview](https://pub.dev/packages/device_preview) - Device testing

---

<div align="center">

**⭐ Jika project ini membantu, berikan star ya! ⭐**

![Made with ❤️ in Indonesia](https://img.shields.io/badge/Made%20with%20❤️-in%20Indonesia-red?style=for-the-badge)

</div>
