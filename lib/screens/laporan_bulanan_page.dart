import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class LaporanBulananPage extends StatefulWidget {
  const LaporanBulananPage({super.key});

  @override
  State<LaporanBulananPage> createState() => _LaporanBulananPageState();
}

class _LaporanBulananPageState extends State<LaporanBulananPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime selectedMonth = DateTime.now();

  // Sample data
  List<MonthlyReport> monthlyReports = [];
  List<DeviceUsage> deviceUsages = [];
  List<CostBreakdown> costBreakdowns = [];
  MonthlyStatistics currentStats = MonthlyStatistics();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _generateSampleData();
  }

  void _generateSampleData() {
    // Generate monthly reports for last 12 months
    monthlyReports = List.generate(12, (index) {
      DateTime month = DateTime(
        DateTime.now().year,
        DateTime.now().month - index,
        1,
      );
      return MonthlyReport(
        month: month,
        totalKwh: 450 + Random().nextDouble() * 200,
        totalCost: (450 + Random().nextDouble() * 200) * 1500,
        averageDaily: (450 + Random().nextDouble() * 200) / 30,
        peakDemand: 2.5 + Random().nextDouble() * 1.5,
        efficiency: 85 + Random().nextDouble() * 15,
      );
    });

    // Generate device usage data
    deviceUsages = [
      DeviceUsage(
        name: 'AC Ruang Tamu',
        icon: Icons.ac_unit,
        kwh: 185.5,
        cost: 278250,
        percentage: 35.2,
        color: const Color(0xFF3B82F6),
      ),
      DeviceUsage(
        name: 'Water Heater',
        icon: Icons.hot_tub,
        kwh: 95.3,
        cost: 142950,
        percentage: 18.1,
        color: const Color(0xFFEF4444),
      ),
      DeviceUsage(
        name: 'Kulkas',
        icon: Icons.kitchen,
        kwh: 78.2,
        cost: 117300,
        percentage: 14.8,
        color: const Color(0xFF10B981),
      ),
      DeviceUsage(
        name: 'Lampu-lampu',
        icon: Icons.lightbulb,
        kwh: 65.4,
        cost: 98100,
        percentage: 12.4,
        color: const Color(0xFFF59E0B),
      ),
      DeviceUsage(
        name: 'TV & Elektronik',
        icon: Icons.tv,
        kwh: 52.1,
        cost: 78150,
        percentage: 9.9,
        color: const Color(0xFF8B5CF6),
      ),
      DeviceUsage(
        name: 'Lainnya',
        icon: Icons.more_horiz,
        kwh: 50.5,
        cost: 75750,
        percentage: 9.6,
        color: const Color(0xFF6B7280),
      ),
    ];

    // Generate cost breakdown
    costBreakdowns = [
      CostBreakdown(
        category: 'Biaya Pemakaian',
        amount: 675000,
        percentage: 85.0,
        color: const Color(0xFF3B82F6),
      ),
      CostBreakdown(
        category: 'Biaya Beban',
        amount: 75000,
        percentage: 9.5,
        color: const Color(0xFF10B981),
      ),
      CostBreakdown(
        category: 'PPN',
        amount: 43500,
        percentage: 5.5,
        color: const Color(0xFFF59E0B),
      ),
    ];

    // Current month statistics
    currentStats = MonthlyStatistics(
      totalKwh: 527.0,
      totalCost: 790500,
      averageDaily: 17.6,
      peakDemand: 3.2,
      efficiency: 88.5,
      carbonFootprint: 263.5,
      comparison: MonthlyComparison(
        kwhChange: 8.5,
        costChange: 12750,
        efficiencyChange: 2.3,
      ),
    );
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
          'Laporan Bulanan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: _downloadReport,
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Ringkasan', icon: Icon(Icons.dashboard)),
            Tab(text: 'Detail', icon: Icon(Icons.analytics)),
            Tab(text: 'Perbandingan', icon: Icon(Icons.compare)),
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
          children: [
            _buildSummaryTab(),
            _buildDetailTab(),
            _buildComparisonTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month Selector
          _buildMonthSelector(),

          const SizedBox(height: 20),

          // Key Metrics
          _buildKeyMetrics(),

          const SizedBox(height: 20),

          // Device Usage Pie Chart
          _buildDeviceUsageChart(),

          const SizedBox(height: 20),

          // Cost Breakdown
          _buildCostBreakdown(),

          const SizedBox(height: 20),

          // Environmental Impact
          _buildEnvironmentalImpact(),
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
          // Device Usage Details
          _buildDeviceUsageDetails(),

          const SizedBox(height: 20),

          // Daily Usage Pattern
          _buildDailyUsagePattern(),

          const SizedBox(height: 20),

          // Efficiency Analysis
          _buildEfficiencyAnalysis(),

          const SizedBox(height: 20),

          // Recommendations
          _buildDetailedRecommendations(),
        ],
      ),
    );
  }

  Widget _buildComparisonTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month-to-Month Comparison
          _buildMonthlyComparison(),

          const SizedBox(height: 20),

          // Yearly Trend
          _buildYearlyTrend(),

          const SizedBox(height: 20),

          // Performance Metrics
          _buildPerformanceMetrics(),

          const SizedBox(height: 20),

          // Cost Analysis
          _buildCostAnalysis(),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Periode Laporan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E3A8A),
            ),
          ),
          GestureDetector(
            onTap: _selectMonth,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getMonthYearString(selectedMonth),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.calendar_month,
                    color: Color(0xFF1E3A8A),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyMetrics() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildMetricCard(
          'Total Konsumsi',
          '${currentStats.totalKwh.toStringAsFixed(1)} kWh',
          Icons.electrical_services,
          const Color(0xFF3B82F6),
          '${currentStats.comparison.kwhChange > 0 ? '+' : ''}${currentStats.comparison.kwhChange.toStringAsFixed(1)}%',
          currentStats.comparison.kwhChange > 0,
        ),
        _buildMetricCard(
          'Total Biaya',
          'Rp ${(currentStats.totalCost / 1000).toStringAsFixed(0)}K',
          Icons.attach_money,
          const Color(0xFF10B981),
          'Rp ${(currentStats.comparison.costChange / 1000).toStringAsFixed(0)}K',
          currentStats.comparison.costChange < 0,
        ),
        _buildMetricCard(
          'Rata-rata Harian',
          '${currentStats.averageDaily.toStringAsFixed(1)} kWh',
          Icons.today,
          const Color(0xFFF59E0B),
          'Per hari',
          null,
        ),
        _buildMetricCard(
          'Efisiensi',
          '${currentStats.efficiency.toStringAsFixed(1)}%',
          Icons.eco,
          const Color(0xFF8B5CF6),
          '${currentStats.comparison.efficiencyChange > 0 ? '+' : ''}${currentStats.comparison.efficiencyChange.toStringAsFixed(1)}%',
          currentStats.comparison.efficiencyChange > 0,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String change,
    bool? isPositive,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              if (isPositive != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    change,
                    style: TextStyle(
                      color: isPositive ? Colors.green : Colors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
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
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          if (isPositive == null)
            Text(
              change,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
        ],
      ),
    );
  }

  Widget _buildDeviceUsageChart() {
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
            'Penggunaan per Perangkat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: deviceUsages.map((device) {
                        return PieChartSectionData(
                          color: device.color,
                          value: device.percentage,
                          title: '${device.percentage.toStringAsFixed(1)}%',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 3,
                child: Column(
                  children: deviceUsages.take(4).map((device) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: device.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              device.name,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          Text(
                            '${device.kwh.toStringAsFixed(1)} kWh',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdown() {
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
            'Rincian Biaya',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 16),
          ...costBreakdowns.map((breakdown) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: breakdown.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      breakdown.category,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Rp ${(breakdown.amount / 1000).toStringAsFixed(0)}K',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      Text(
                        '${breakdown.percentage.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              Text(
                'Rp ${(currentStats.totalCost / 1000).toStringAsFixed(0)}K',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnvironmentalImpact() {
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
              const Icon(Icons.eco, color: Color(0xFF10B981), size: 24),
              const SizedBox(width: 8),
              const Text(
                'Dampak Lingkungan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildEnvironmentMetric(
                  'Carbon Footprint',
                  '${currentStats.carbonFootprint.toStringAsFixed(1)} kg CO₂',
                  Icons.cloud,
                  Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildEnvironmentMetric(
                  'Setara Pohon',
                  '${(currentStats.carbonFootprint / 22).toStringAsFixed(0)} pohon',
                  Icons.forest,
                  const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnvironmentMetric(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildDeviceUsageDetails() {
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
            'Detail Penggunaan Perangkat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 16),
          ...deviceUsages.map((device) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: device.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(device.icon, color: device.color, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        Text(
                          '${device.percentage.toStringAsFixed(1)}% dari total',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${device.kwh.toStringAsFixed(1)} kWh',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      Text(
                        'Rp ${(device.cost / 1000).toStringAsFixed(0)}K',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDailyUsagePattern() {
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
            'Pola Penggunaan Harian',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 5,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
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
                      interval: 6,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            '${value.toInt()}:00',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            '${value.toInt()}kW',
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
                minX: 0,
                maxX: 23,
                minY: 0,
                maxY: 25,
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(24, (index) {
                      double baseUsage = 5;
                      if (index >= 6 && index <= 8)
                        baseUsage += 8; // Morning peak
                      if (index >= 18 && index <= 22)
                        baseUsage += 12; // Evening peak
                      return FlSpot(
                        index.toDouble(),
                        baseUsage + Random().nextDouble() * 3,
                      );
                    }),
                    isCurved: true,
                    color: const Color(0xFF3B82F6),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF3B82F6).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEfficiencyAnalysis() {
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
            'Analisis Efisiensi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 16),
          _buildEfficiencyItem(
            'Power Factor',
            0.95,
            'Sangat Baik',
            Colors.green,
          ),
          _buildEfficiencyItem('Load Factor', 0.72, 'Baik', Colors.blue),
          _buildEfficiencyItem(
            'Energy Efficiency',
            0.88,
            'Baik',
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildEfficiencyItem(
    String title,
    double value,
    String status,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(
                '${(value * 100).toStringAsFixed(1)}%',
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedRecommendations() {
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
            'Rekomendasi Optimasi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 16),
          _buildRecommendationCard(
            'Prioritas Tinggi',
            'Optimasi AC Ruang Tamu',
            'AC mengkonsumsi 35% dari total energi. Pertimbangkan upgrade ke inverter AC.',
            'Potensi penghematan: Rp 83K/bulan',
            Icons.priority_high,
            Colors.red,
          ),
          _buildRecommendationCard(
            'Prioritas Sedang',
            'Jadwal Water Heater',
            'Gunakan timer untuk water heater pada jam non-puncak (22:00-05:00).',
            'Potensi penghematan: Rp 25K/bulan',
            Icons.schedule,
            Colors.orange,
          ),
          _buildRecommendationCard(
            'Prioritas Rendah',
            'LED Upgrade',
            'Ganti lampu konvensional dengan LED untuk efisiensi lebih baik.',
            'Potensi penghematan: Rp 15K/bulan',
            Icons.lightbulb,
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(
    String priority,
    String title,
    String description,
    String saving,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        priority,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  saving,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyComparison() {
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
            'Perbandingan Bulan ke Bulan',
            style: TextStyle(
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
                maxY: 700,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => const Color(0xFF1E3A8A),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${monthlyReports[group.x.toInt()].totalKwh.toStringAsFixed(1)} kWh\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'Rp ${(monthlyReports[group.x.toInt()].totalCost / 1000).toStringAsFixed(0)}K',
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
                        if (index >= 0 &&
                            index < monthlyReports.length &&
                            index < 6) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              _getShortMonthName(monthlyReports[index].month),
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
                      interval: 100,
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
                barGroups: monthlyReports.take(6).toList().asMap().entries.map((
                  entry,
                ) {
                  int index = entry.key;
                  MonthlyReport report = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: report.totalKwh,
                        color: index == 0
                            ? const Color(0xFF3B82F6)
                            : Colors.grey.withOpacity(0.5),
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

  Widget _buildYearlyTrend() {
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
            'Tren Tahunan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 100,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
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
                      interval: 2,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < monthlyReports.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              _getShortMonthName(monthlyReports[index].month),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
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
                      interval: 100,
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
                minX: 0,
                maxX: 11,
                minY: 300,
                maxY: 700,
                lineBarsData: [
                  LineChartBarData(
                    spots: monthlyReports.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.totalKwh);
                    }).toList(),
                    isCurved: true,
                    color: const Color(0xFF3B82F6),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF3B82F6).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
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
            'Metrik Performa',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPerformanceCard(
                  'Konsistensi',
                  '92%',
                  'Penggunaan stabil',
                  Icons.trending_flat,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPerformanceCard(
                  'Efisiensi',
                  '88%',
                  'Di atas rata-rata',
                  Icons.trending_up,
                  Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPerformanceCard(
                  'Prediksi',
                  'Rp 825K',
                  'Bulan depan',
                  Icons.timeline,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPerformanceCard(
                  'Target',
                  '95%',
                  'Tercapai',
                  Icons.check_circle,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E3A8A),
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCostAnalysis() {
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
            'Analisis Biaya',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 16),
          _buildCostAnalysisItem(
            'Biaya per kWh',
            'Rp 1.500',
            'Tarif saat ini',
            Icons.bolt,
          ),
          _buildCostAnalysisItem(
            'Rata-rata Industri',
            'Rp 1.467',
            'Lebih tinggi 2.2%',
            Icons.analytics,
          ),
          _buildCostAnalysisItem(
            'Proyeksi Tahunan',
            'Rp 9.5 Juta',
            'Berdasarkan trend',
            Icons.calendar_today,
          ),
          _buildCostAnalysisItem(
            'Potensi Penghematan',
            'Rp 123K',
            'Per bulan',
            Icons.savings,
          ),
        ],
      ),
    );
  }

  Widget _buildCostAnalysisItem(
    String title,
    String value,
    String subtitle,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
        ],
      ),
    );
  }

  void _selectMonth() {
    showDatePicker(
      context: context,
      initialDate: selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: 'Pilih Bulan Laporan',
    ).then((date) {
      if (date != null) {
        setState(() {
          selectedMonth = date;
        });
      }
    });
  }

  void _downloadReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur download laporan akan segera hadir'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  String _getMonthYearString(DateTime date) {
    List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  String _getShortMonthName(DateTime date) {
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
    return months[date.month - 1];
  }
}

// Data Models
class MonthlyReport {
  final DateTime month;
  final double totalKwh;
  final double totalCost;
  final double averageDaily;
  final double peakDemand;
  final double efficiency;

  MonthlyReport({
    required this.month,
    required this.totalKwh,
    required this.totalCost,
    required this.averageDaily,
    required this.peakDemand,
    required this.efficiency,
  });
}

class DeviceUsage {
  final String name;
  final IconData icon;
  final double kwh;
  final double cost;
  final double percentage;
  final Color color;

  DeviceUsage({
    required this.name,
    required this.icon,
    required this.kwh,
    required this.cost,
    required this.percentage,
    required this.color,
  });
}

class CostBreakdown {
  final String category;
  final double amount;
  final double percentage;
  final Color color;

  CostBreakdown({
    required this.category,
    required this.amount,
    required this.percentage,
    required this.color,
  });
}

class MonthlyStatistics {
  final double totalKwh;
  final double totalCost;
  final double averageDaily;
  final double peakDemand;
  final double efficiency;
  final double carbonFootprint;
  final MonthlyComparison comparison;

  MonthlyStatistics({
    this.totalKwh = 0,
    this.totalCost = 0,
    this.averageDaily = 0,
    this.peakDemand = 0,
    this.efficiency = 0,
    this.carbonFootprint = 0,
    this.comparison = const MonthlyComparison(),
  });
}

class MonthlyComparison {
  final double kwhChange;
  final double costChange;
  final double efficiencyChange;

  const MonthlyComparison({
    this.kwhChange = 0,
    this.costChange = 0,
    this.efficiencyChange = 0,
  });
}
