import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class RiwayatPenggunaanPage extends StatefulWidget {
  const RiwayatPenggunaanPage({super.key});

  @override
  State<RiwayatPenggunaanPage> createState() => _RiwayatPenggunaanPageState();
}

class _RiwayatPenggunaanPageState extends State<RiwayatPenggunaanPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedPeriod = 'Harian';
  List<String> periods = ['Harian', 'Mingguan', 'Bulanan'];

  // Sample data for different periods
  List<BarData> dailyData = [];
  List<BarData> weeklyData = [];
  List<BarData> monthlyData = [];

  // Summary data
  double totalKwh = 0;
  double totalCost = 0;
  double averageDaily = 0;
  double peakUsage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _generateSampleData();
    _calculateSummary();
  }

  void _generateSampleData() {
    // Generate daily data (last 7 days)
    dailyData = List.generate(7, (index) {
      return BarData(
        label: _getDayLabel(index),
        value: 15 + Random().nextDouble() * 20, // 15-35 kWh
        cost: (15 + Random().nextDouble() * 20) * 1500, // Rp 1500 per kWh
      );
    });

    // Generate weekly data (last 4 weeks)
    weeklyData = List.generate(4, (index) {
      return BarData(
        label: 'Minggu ${index + 1}',
        value: 100 + Random().nextDouble() * 80, // 100-180 kWh
        cost: (100 + Random().nextDouble() * 80) * 1500,
      );
    });

    // Generate monthly data (last 6 months)
    monthlyData = List.generate(6, (index) {
      return BarData(
        label: _getMonthLabel(index),
        value: 400 + Random().nextDouble() * 200, // 400-600 kWh
        cost: (400 + Random().nextDouble() * 200) * 1500,
      );
    });
  }

  void _calculateSummary() {
    totalKwh = monthlyData.fold(0, (sum, data) => sum + data.value);
    totalCost = monthlyData.fold(0, (sum, data) => sum + data.cost);
    averageDaily = totalKwh / 30;
    peakUsage = monthlyData
        .map((data) => data.value)
        .reduce((a, b) => a > b ? a : b);
  }

  String _getDayLabel(int index) {
    List<String> days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    DateTime now = DateTime.now();
    DateTime day = now.subtract(Duration(days: 6 - index));
    return days[day.weekday - 1];
  }

  String _getMonthLabel(int index) {
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    DateTime now = DateTime.now();
    DateTime month = DateTime(now.year, now.month - (5 - index), 1);
    return months[month.month - 1];
  }

  List<BarData> getCurrentData() {
    switch (selectedPeriod) {
      case 'Harian':
        return dailyData;
      case 'Mingguan':
        return weeklyData;
      case 'Bulanan':
        return monthlyData;
      default:
        return dailyData;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Penggunaan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Grafik', icon: Icon(Icons.bar_chart)),
            Tab(text: 'Detail', icon: Icon(Icons.list)),
          ],
        ),
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
        child: TabBarView(
          controller: _tabController,
          children: [_buildChartTab(), _buildDetailTab()],
        ),
      ),
    );
  }

  Widget _buildChartTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          _buildSummaryCards(),

          const SizedBox(height: 20),

          // Period Selector
          _buildPeriodSelector(),

          const SizedBox(height: 20),

          // Chart Section
          _buildChartSection(),

          const SizedBox(height: 20),

          // Trend Analysis
          _buildTrendAnalysis(),
        ],
      ),
    );
  }

  Widget _buildDetailTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Monthly Statistics
          _buildMonthlyStatistics(),

          const SizedBox(height: 20),

          // Usage List
          _buildUsageList(),

          const SizedBox(height: 20),

          // Recommendations
          _buildRecommendations(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: [
        _buildSummaryCard(
          'Total Energi',
          '${totalKwh.toStringAsFixed(1)} kWh',
          Icons.electrical_services,
          const Color(0xFF3B82F6),
          '6 bulan terakhir',
        ),
        _buildSummaryCard(
          'Total Biaya',
          'Rp ${(totalCost / 1000).toStringAsFixed(0)}K',
          Icons.attach_money,
          const Color(0xFF10B981),
          '6 bulan terakhir',
        ),
        _buildSummaryCard(
          'Rata-rata Harian',
          '${averageDaily.toStringAsFixed(1)} kWh',
          Icons.trending_up,
          const Color(0xFFF59E0B),
          'Per hari',
        ),
        _buildSummaryCard(
          'Puncak Penggunaan',
          '${peakUsage.toStringAsFixed(1)} kWh',
          Icons.whatshot,
          const Color(0xFFEF4444),
          'Tertinggi',
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Icon(icon, color: color, size: 24),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
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
      child: Row(
        children: periods.map((period) {
          bool isSelected = selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = period;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1E3A8A)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChartSection() {
    List<BarData> data = getCurrentData();

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
          Text(
            'Konsumsi Energi $selectedPeriod',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY:
                    data.map((d) => d.value).reduce((a, b) => a > b ? a : b) *
                    1.2,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => const Color(0xFF1E3A8A),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${data[group.x.toInt()].value.toStringAsFixed(1)} kWh\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'Rp ${(data[group.x.toInt()].cost / 1000).toStringAsFixed(0)}K',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < data.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              data[index].label,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: selectedPeriod == 'Bulanan' ? 100 : 10,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            '${value.toInt()}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: data.asMap().entries.map((entry) {
                  int index = entry.key;
                  BarData barData = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: barData.value,
                        color: const Color(0xFF3B82F6),
                        width: 16,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis() {
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
          const Text(
            'Analisis Tren',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 16),
          _buildTrendItem(
            'Efisiensi Energi',
            'Meningkat 12%',
            'Penggunaan lebih efisien dibanding bulan lalu',
            Icons.trending_up,
            Colors.green,
          ),
          _buildTrendItem(
            'Biaya Rata-rata',
            'Rp 675K/bulan',
            'Stabil dalam 3 bulan terakhir',
            Icons.attach_money,
            Colors.blue,
          ),
          _buildTrendItem(
            'Puncak Penggunaan',
            'Pukul 19:00-21:00',
            'Waktu penggunaan tertinggi',
            Icons.schedule,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendItem(
    String title,
    String value,
    String description,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyStatistics() {
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
          const Text(
            'Statistik Bulanan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 16),
          _buildStatRow('Bulan Ini', '524.3 kWh', 'Rp 786.450', true),
          _buildStatRow('Bulan Lalu', '492.1 kWh', 'Rp 738.150', false),
          _buildStatRow('Rata-rata 6 Bulan', '485.7 kWh', 'Rp 728.550', false),
          const Divider(),
          _buildStatRow(
            'Selisih vs Rata-rata',
            '+38.6 kWh',
            '+Rp 57.900',
            null,
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(
    String period,
    String kwh,
    String cost,
    bool? isHighlight,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            period,
            style: TextStyle(
              fontWeight: isHighlight == true
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: isHighlight == true
                  ? const Color(0xFF1E3A8A)
                  : Colors.grey,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                kwh,
                style: TextStyle(
                  fontWeight: isHighlight == true
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: isHighlight == true
                      ? const Color(0xFF1E3A8A)
                      : Colors.black87,
                ),
              ),
              Text(
                cost,
                style: TextStyle(
                  fontSize: 12,
                  color: isHighlight == true
                      ? const Color(0xFF10B981)
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUsageList() {
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
          const Text(
            'Penggunaan Harian (7 Hari Terakhir)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 16),
          ...dailyData.reversed.map((data) => _buildUsageItem(data)).toList(),
        ],
      ),
    );
  }

  Widget _buildUsageItem(BarData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF3B82F6),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              data.label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${data.value.toStringAsFixed(1)} kWh',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              Text(
                'Rp ${(data.cost / 1000).toStringAsFixed(0)}K',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
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
          const Text(
            'Rekomendasi Hemat Energi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 16),
          _buildRecommendationItem(
            'Gunakan AC pada suhu 24-26°C',
            'Dapat menghemat hingga 15% energi',
            Icons.ac_unit,
            Colors.blue,
          ),
          _buildRecommendationItem(
            'Cabut alat elektronik saat tidak digunakan',
            'Mencegah konsumsi daya standby',
            Icons.power_off,
            Colors.orange,
          ),
          _buildRecommendationItem(
            'Gunakan lampu LED',
            'Hemat energi hingga 80%',
            Icons.lightbulb_outline,
            Colors.yellow,
          ),
          _buildRecommendationItem(
            'Optimalkan penggunaan di jam non-puncak',
            'Tarif listrik lebih murah',
            Icons.schedule,
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BarData {
  final String label;
  final double value;
  final double cost;

  BarData({required this.label, required this.value, required this.cost});
}
