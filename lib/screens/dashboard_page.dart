import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isElectricityOn = true; // Status listrik (hidup/mati)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard Monitoring Listrik',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Monitor penggunaan listrik Anda dengan mudah',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Quick Stats
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Konsumsi Hari Ini',
                        '245 kWh',
                        Icons.flash_on,
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Biaya Bulan Ini',
                        'Rp 450.000',
                        Icons.attach_money,
                        Colors.green,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Power Control Section
                _buildPowerControlSection(),

                const SizedBox(height: 24),

                // Menu Grid
                const Text(
                  'Menu Utama',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 16),

                // Grid Menu dengan tinggi yang fixed
                SizedBox(
                  height: 350, // Fixed height untuk grid 2x2
                  child: GridView.count(
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable scroll untuk grid
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildMenuCard(
                        'Monitoring Real-time',
                        Icons.monitor,
                        Colors.blue,
                        () {
                          Navigator.of(context).pushNamed('/monitoring');
                        },
                      ),
                      _buildMenuCard(
                        'Riwayat Penggunaan',
                        Icons.history,
                        Colors.purple,
                        () {
                          Navigator.of(context).pushNamed('/riwayat');
                        },
                      ),
                      _buildMenuCard(
                        'Laporan Bulanan',
                        Icons.assessment,
                        Colors.teal,
                        () {
                          Navigator.of(context).pushNamed('/laporan');
                        },
                      ),
                      _buildMenuCard(
                        'Pengaturan',
                        Icons.settings,
                        Colors.grey,
                        () {
                          Navigator.of(context).pushNamed('/pengaturan');
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Additional content area (optional for future features)
                Container(
                  width: double.infinity,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: const Color(0xFF1E3A8A),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Tips Hemat Energi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '• Matikan perangkat yang tidak digunakan\n'
                        '• Gunakan AC pada suhu 24-26°C\n'
                        '• Ganti lampu dengan LED hemat energi\n'
                        '• Cabut charger yang tidak digunakan',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom padding untuk memberikan ruang dengan bottom navigation
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E3A8A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPowerControlSection() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.power_settings_new,
                color: _isElectricityOn ? Colors.green : Colors.red,
                size: 28,
              ),
              const SizedBox(width: 12),
              const Text(
                'Kontrol Listrik Utama',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isElectricityOn
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isElectricityOn
                    ? Colors.green.withOpacity(0.3)
                    : Colors.red.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isElectricityOn ? 'Listrik Menyala' : 'Listrik Mati',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _isElectricityOn
                              ? Colors.green[700]
                              : Colors.red[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _isElectricityOn
                            ? 'Semua perangkat dapat beroperasi normal'
                            : 'Semua perangkat listrik dimatikan',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _showPowerConfirmationDialog,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 60,
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: _isElectricityOn ? Colors.green : Colors.grey[400],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      alignment: _isElectricityOn
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isElectricityOn ? Icons.power : Icons.power_off,
                          color: _isElectricityOn ? Colors.green : Colors.red,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Pastikan tidak ada perangkat penting yang sedang berjalan sebelum mematikan listrik',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPowerConfirmationDialog() {
    final bool willTurnOn = !_isElectricityOn;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                willTurnOn ? Icons.power_settings_new : Icons.power_off,
                color: willTurnOn ? Colors.green : Colors.red,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                willTurnOn ? 'Nyalakan Listrik' : 'Matikan Listrik',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                willTurnOn
                    ? 'Apakah Anda yakin ingin menyalakan listrik utama?'
                    : 'Apakah Anda yakin ingin mematikan listrik utama?',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: willTurnOn
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: willTurnOn
                        ? Colors.green.withOpacity(0.3)
                        : Colors.red.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      willTurnOn ? Icons.lightbulb : Icons.warning,
                      color: willTurnOn ? Colors.green[700] : Colors.red[700],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        willTurnOn
                            ? 'Semua perangkat akan kembali menyala dan dapat beroperasi normal.'
                            : 'Semua perangkat listrik akan dimatikan dan tidak dapat beroperasi.',
                        style: TextStyle(
                          fontSize: 14,
                          color: willTurnOn
                              ? Colors.green[700]
                              : Colors.red[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Batal',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _toggleElectricity();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: willTurnOn ? Colors.green : Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                willTurnOn ? 'Nyalakan' : 'Matikan',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleElectricity() {
    setState(() {
      _isElectricityOn = !_isElectricityOn;
    });

    // Show success notification
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _isElectricityOn ? Icons.check_circle : Icons.power_off,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              _isElectricityOn
                  ? 'Listrik berhasil dinyalakan!'
                  : 'Listrik berhasil dimatikan!',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: _isElectricityOn ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
