import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'services/auth_service.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
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

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading screen while checking auth status
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1E3A8A), // Blue 900
                    Color(0xFF3B82F6), // Blue 500
                    Color(0xFF60A5FA), // Blue 400
                  ],
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'WattMate',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Memuat...',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // If logged in, go to dashboard; otherwise, go to login
        if (snapshot.hasData && snapshot.data == true) {
          return const DashboardPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
