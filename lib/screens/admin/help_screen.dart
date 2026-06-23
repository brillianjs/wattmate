import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009688),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Bantuan & Dukungan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF009688), Color(0xFF00796B)],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.help_outline,
                      size: 60,
                      color: Color(0xFF009688),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ada yang bisa kami bantu?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Kami siap membantu Anda 24/7',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact Options
                  const Text(
                    'Hubungi Kami',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactCard(
                    context,
                    icon: Icons.chat_bubble_outline,
                    title: 'WhatsApp Support',
                    subtitle: '+62 812-3456-7890',
                    color: const Color(0xFF25D366),
                    onTap: () {
                      _launchWhatsApp(context);
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    context,
                    icon: Icons.email_outlined,
                    title: 'Email Support',
                    subtitle: 'support@wattmate.com',
                    color: const Color(0xFF009688),
                    onTap: () {
                      _launchEmail(context);
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    context,
                    icon: Icons.phone_outlined,
                    title: 'Telepon',
                    subtitle: '+62 21 1234 5678',
                    color: const Color(0xFF2196F3),
                    onTap: () {
                      _launchPhone(context);
                    },
                  ),

                  const SizedBox(height: 24),

                  // FAQ Section
                  const Text(
                    'Pertanyaan Umum (FAQ)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFAQCard(
                    question: 'Bagaimana cara menambah kamar baru?',
                    answer:
                        'Buka menu Kamar, lalu klik tombol + di pojok kanan bawah. Isi detail kamar dan klik Simpan.',
                  ),
                  const SizedBox(height: 12),
                  _buildFAQCard(
                    question:
                        'Bagaimana cara mengirim pesan broadcast WhatsApp?',
                    answer:
                        'Buka menu WhatsApp, pilih template pesan, pilih penerima, lalu klik Kirim Sekarang.',
                  ),
                  const SizedBox(height: 12),
                  _buildFAQCard(
                    question: 'Bagaimana cara melihat laporan bulanan?',
                    answer:
                        'Buka menu Laporan, pilih periode bulan yang diinginkan, kemudian klik Export untuk menyimpan PDF.',
                  ),
                  const SizedBox(height: 12),
                  _buildFAQCard(
                    question: 'Apakah data saya aman?',
                    answer:
                        'Ya, semua data dienkripsi dan disimpan dengan aman. Kami menggunakan standar keamanan industri untuk melindungi data Anda.',
                  ),

                  const SizedBox(height: 24),

                  // Features Guide
                  const Text(
                    'Panduan Fitur',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureCard(
                    icon: Icons.dashboard_outlined,
                    title: 'Dashboard',
                    description:
                        'Pantau statistik kos, penggunaan listrik real-time, dan peringatan kamar kritis.',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    icon: Icons.meeting_room,
                    title: 'Manajemen Kamar',
                    description:
                        'Kelola data kamar, penyewa, status kamar, dan saldo token listrik.',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    icon: Icons.payment,
                    title: 'Transaksi',
                    description:
                        'Lihat riwayat transaksi, status pembayaran, dan detail transaksi penyewa.',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    icon: Icons.chat,
                    title: 'WhatsApp Bot',
                    description:
                        'Kirim pesan broadcast otomatis untuk pengingat pembayaran dan notifikasi.',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    icon: Icons.analytics,
                    title: 'Laporan',
                    description:
                        'Generate laporan bulanan dengan statistik lengkap dan export ke PDF.',
                  ),

                  const SizedBox(height: 24),

                  // App Info
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF009688), Color(0xFF00796B)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.home_work,
                          color: Colors.white,
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'WattMate Admin',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Versi 1.0.0',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Aplikasi manajemen listrik kos untuk memantau penggunaan daya, transaksi token, dan komunikasi dengan penyewa.',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '© 2024 WattMate. All rights reserved.',
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQCard({required String question, required String answer}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
          splashColor: const Color(0xFF009688).withOpacity(0.1),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          iconColor: const Color(0xFF009688),
          collapsedIconColor: Colors.grey,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF009688).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF009688), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchWhatsApp(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Membuka WhatsApp...'),
        duration: Duration(seconds: 2),
      ),
    );
    // Implementasi actual: launchUrl(Uri.parse('https://wa.me/628123456789'))
  }

  void _launchEmail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Membuka email client...'),
        duration: Duration(seconds: 2),
      ),
    );
    // Implementasi actual: launchUrl(Uri.parse('mailto:support@wattmate.com'))
  }

  void _launchPhone(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Membuka telepon...'),
        duration: Duration(seconds: 2),
      ),
    );
    // Implementasi actual: launchUrl(Uri.parse('tel:+622112345678'))
  }
}
