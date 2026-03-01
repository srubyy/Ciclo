import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'models.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WasteStore>(
      builder: (context, store, child) {
        if (store.entries.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🗑️', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 24),
                const Text('No data yet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                const Text('Start logging your household waste to see analytics and trends here.', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(LucideIcons.plusCircle, size: 16, color: Color(0xFF0a120d)),
                      label: const Text('Log Waste', style: TextStyle(color: Color(0xFF0a120d), fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4ade80), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () => store.seedDemoData(),
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: const Text('Load Demo Data', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        final stats = store.getStats();
        final weeklyData = store.getWeeklyData();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text('${store.profile.name.isNotEmpty ? store.profile.name : "Your household"} · ${store.profile.location}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 32),
              
              // Stats Row
              Row(
                children: [
                  Expanded(child: _statCard('Total Waste', '${stats.totalAll}', 'kg', '⚖️', const Color(0xFF4ade80))),
                  const SizedBox(width: 16),
                  Expanded(child: _statCard('Daily Avg', '${stats.avgDaily}', 'kg/day', '📅', const Color(0xFF2dd4bf))),
                  const SizedBox(width: 16),
                  Expanded(child: _statCard('Per Capita', '${stats.perCapita}', 'kg/person', '👤', const Color(0xFF60a5fa))),
                  const SizedBox(width: 16),
                  Expanded(child: _statCard('Entries', '${store.entries.length}', 'days', '📋', const Color(0xFFc084fc))),
                ],
              ),
              const SizedBox(height: 24),
              
              // Middle Row: Pie Chart and Bar Chart
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pie Chart
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 300,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(color: const Color(0xFF141f18), border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Composition', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                          const SizedBox(height: 24),
                          Expanded(
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 2,
                                centerSpaceRadius: 40,
                                sections: [
                                  if (stats.totalWet > 0) PieChartSectionData(color: const Color(0xFF2dd4bf), value: stats.totalWet, title: '', radius: 30),
                                  if (stats.totalDry > 0) PieChartSectionData(color: const Color(0xFFf59e0b), value: stats.totalDry, title: '', radius: 30),
                                  if (stats.totalRecyclable > 0) PieChartSectionData(color: const Color(0xFF60a5fa), value: stats.totalRecyclable, title: '', radius: 30),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _pieLegendItem('Wet', '${stats.totalWet} kg', const Color(0xFF2dd4bf)),
                          _pieLegendItem('Dry', '${stats.totalDry} kg', const Color(0xFFf59e0b)),
                          _pieLegendItem('Recyclable', '${stats.totalRecyclable} kg', const Color(0xFF60a5fa)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Weekly Bar Chart
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 300,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(color: const Color(0xFF141f18), border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Weekly Trend', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                          const SizedBox(height: 24),
                          Expanded(
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (value) => FlLine(color: Colors.white10, strokeWidth: 1, dashArray: [3, 3])),
                                borderData: FlBorderData(show: false),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30, getTitlesWidget: (val, meta) => Text(val.toStringAsFixed(0), style: const TextStyle(color: Colors.grey, fontSize: 11)))),
                                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (val, meta) {
                                        if (val.toInt() >= 0 && val.toInt() < weeklyData.length) {
                                          return Padding(
                                              padding: const EdgeInsets.only(top: 8),
                                              child: Text(weeklyData[val.toInt()].label.substring(0, 3), style: const TextStyle(color: Colors.grey, fontSize: 11)));
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                  ),
                                ),
                                barGroups: List.generate(
                                  weeklyData.length,
                                  (i) => BarChartGroupData(
                                    x: i,
                                    barRods: [
                                      BarChartRodData(toY: weeklyData[i].wet, color: const Color(0xFF2dd4bf), width: 6, borderRadius: const BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3))),
                                      BarChartRodData(toY: weeklyData[i].dry, color: const Color(0xFFf59e0b), width: 6, borderRadius: const BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3))),
                                      BarChartRodData(toY: weeklyData[i].recyclable, color: const Color(0xFF60a5fa), width: 6, borderRadius: const BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              
              // Progress Bars Row
              Row(
                children: [
                  Expanded(child: _progressBar('Wet Waste', stats.wetPercentage, const Color(0xFF2dd4bf))),
                  const SizedBox(width: 16),
                  Expanded(child: _progressBar('Dry Waste', stats.dryPercentage, const Color(0xFFf59e0b))),
                  const SizedBox(width: 16),
                  Expanded(child: _progressBar('Recyclable', stats.recyclablePercentage, const Color(0xFF60a5fa))),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _statCard(String label, String value, String unit, String icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: color.withOpacity(0.1), border: Border.all(color: color.withOpacity(0.2)), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label.toUpperCase(), style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              Text(icon, style: const TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.bold, height: 1.1)),
              const SizedBox(width: 8),
              Text(unit, style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.8)),
            ],
          )
        ],
      ),
    );
  }

  Widget _pieLegendItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _progressBar(String label, double pct, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withOpacity(0.05), border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          Text('$pct%', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(3)),
            child: Row(
              children: [
                Expanded(flex: (pct * 10).toInt(), child: Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)))),
                Expanded(flex: pct < 100 ? ((100 - pct) * 10).toInt() : 0, child: const SizedBox()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
