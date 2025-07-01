import 'package:flutter/material.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  bool _notifikasiHarian = true;
  bool _notifikasiMingguan = true;
  bool _notifikasiBatasKonsumsi = false;
  bool _modeDarkMode = false;
  bool _autoBackup = true;
  String _bahasa = 'Bahasa Indonesia';
  String _satuanEnergi = 'kWh';
  String _matauang = 'IDR';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A8A), Color(0xFFF8FAFC)],
            stops: [0.0, 0.3],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Profile Section
                    _buildProfileSection(),

                    const SizedBox(height: 30),

                    // Notifikasi Section
                    _buildSectionTitle('Notifikasi'),
                    const SizedBox(height: 16),
                    _buildNotificationSettings(),

                    const SizedBox(height: 30),

                    // Tampilan Section
                    _buildSectionTitle('Tampilan'),
                    const SizedBox(height: 16),
                    _buildDisplaySettings(),

                    const SizedBox(height: 30),

                    // Data & Backup Section
                    _buildSectionTitle('Data & Backup'),
                    const SizedBox(height: 16),
                    _buildDataSettings(),

                    const SizedBox(height: 30),

                    // Tentang Section
                    _buildSectionTitle('Tentang'),
                    const SizedBox(height: 16),
                    _buildAboutSettings(),

                    const SizedBox(height: 100), // Space for logout button
                  ],
                ),
              ),
            ),

            // Logout Button at Bottom
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF1E3A8A)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'john.doe@email.com',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Premium User',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF10B981),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _editProfile,
            icon: const Icon(Icons.edit, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E3A8A),
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            'Notifikasi Harian',
            'Laporan konsumsi listrik harian',
            Icons.today,
            _notifikasiHarian,
            (value) => setState(() => _notifikasiHarian = value),
          ),
          _buildDivider(),
          _buildSwitchTile(
            'Laporan Mingguan',
            'Ringkasan penggunaan mingguan',
            Icons.calendar_view_week,
            _notifikasiMingguan,
            (value) => setState(() => _notifikasiMingguan = value),
          ),
          _buildDivider(),
          _buildSwitchTile(
            'Peringatan Batas Konsumsi',
            'Notifikasi saat mendekati batas',
            Icons.warning,
            _notifikasiBatasKonsumsi,
            (value) => setState(() => _notifikasiBatasKonsumsi = value),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplaySettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            'Mode Gelap',
            'Tampilan dengan tema gelap',
            Icons.dark_mode,
            _modeDarkMode,
            (value) => setState(() => _modeDarkMode = value),
          ),
          _buildDivider(),
          _buildDropdownTile(
            'Bahasa',
            _bahasa,
            Icons.language,
            ['Bahasa Indonesia', 'English', 'Español'],
            (value) => setState(() => _bahasa = value!),
          ),
          _buildDivider(),
          _buildDropdownTile(
            'Satuan Energi',
            _satuanEnergi,
            Icons.flash_on,
            ['kWh', 'MWh', 'GWh'],
            (value) => setState(() => _satuanEnergi = value!),
          ),
          _buildDivider(),
          _buildDropdownTile(
            'Mata Uang',
            _matauang,
            Icons.attach_money,
            ['IDR', 'USD', 'EUR'],
            (value) => setState(() => _matauang = value!),
          ),
        ],
      ),
    );
  }

  Widget _buildDataSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            'Auto Backup',
            'Backup otomatis data ke cloud',
            Icons.cloud_upload,
            _autoBackup,
            (value) => setState(() => _autoBackup = value),
          ),
          _buildDivider(),
          _buildActionTile(
            'Export Data',
            'Unduh data dalam format CSV',
            Icons.download,
            _exportData,
          ),
          _buildDivider(),
          _buildActionTile(
            'Reset Data',
            'Hapus semua data penggunaan',
            Icons.delete_forever,
            _resetData,
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildActionTile(
            'Bantuan & FAQ',
            'Pertanyaan yang sering diajukan',
            Icons.help,
            _showHelp,
          ),
          _buildDivider(),
          _buildActionTile(
            'Kebijakan Privasi',
            'Lihat kebijakan privasi aplikasi',
            Icons.privacy_tip,
            _showPrivacyPolicy,
          ),
          _buildDivider(),
          _buildActionTile(
            'Tentang Aplikasi',
            'Versi 1.0.0 - WattMate',
            Icons.info,
            _showAbout,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF3B82F6), size: 20),
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
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String value,
    IconData icon,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF3B82F6), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E3A8A),
              ),
            ),
          ),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            underline: Container(),
            style: const TextStyle(
              color: Color(0xFF3B82F6),
              fontWeight: FontWeight.w500,
            ),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDestructive
                    ? const Color(0xFFEF4444).withOpacity(0.1)
                    : const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isDestructive
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF3B82F6),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDestructive
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF1E3A8A),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey[200], indent: 60);
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _logout,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEF4444),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Keluar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Action Methods
  void _editProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur edit profil akan segera hadir'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil diekspor ke Downloads'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _resetData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Data'),
          content: const Text(
            'Apakah Anda yakin ingin menghapus semua data penggunaan? '
            'Tindakan ini tidak dapat dibatalkan.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Semua data telah dihapus'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFEF4444),
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _showHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Membuka halaman bantuan'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showPrivacyPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Membuka kebijakan privasi'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showAbout() {
    showAboutDialog(
      context: context,
      applicationName: 'WattMate',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF1E3A8A)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.electrical_services,
          color: Colors.white,
          size: 30,
        ),
      ),
      children: [
        const Text(
          'WattMate adalah aplikasi monitoring listrik cerdas yang membantu Anda '
          'mengontrol dan mengoptimalkan penggunaan energi listrik di rumah atau kantor.',
        ),
      ],
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFEF4444),
              ),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}
