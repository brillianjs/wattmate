import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'screens/login_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/monitoring_realtime_page.dart';
import 'screens/riwayat_penggunaan_page.dart';
import 'screens/laporan_bulanan_page.dart';
import 'screens/pengaturan_page.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enable device preview only in debug mode
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitoring Listrik',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true, // Required for device preview
      locale: DevicePreview.locale(context), // Required for device preview
      builder: DevicePreview.appBuilder, // Required for device preview
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/monitoring': (context) => const MonitoringRealtimePage(),
        '/riwayat': (context) => const RiwayatPenggunaanPage(),
        '/laporan': (context) => const LaporanBulananPage(),
        '/pengaturan': (context) => const PengaturanPage(),
      },
    );
  }
}
