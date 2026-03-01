import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'models.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _view = 'weekly';

  @override
  Widget build(BuildContext context) {
    return Consumer<WasteStore>(
      builder: (context, store, child) {
        if (store.entries.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('📊', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 24),
                const Text('Log at least one entry to see analytics.', style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {}, // Handled by AppLayout state ideally, or just empty
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4ade80), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text('Start Logging', style: TextStyle(color: Color(0xFF0a120d), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        }

        final stats = store.getStats();
        final chartData = _view == 'weekly' ? store.getWeeklyData() : store.getMonthlyData();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Analytics', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              const Text('In-depth analysis of your waste generation patterns', style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 32),

              // Toggle View
              Row(
                children: [
                  _toggleBtn('weekly', 'Weekly'),
                  const SizedBox(width: 8),
                  _toggleBtn('monthly', 'Monthly'),
                ],
              ),
              const SizedBox(height: 24),

              // Area Trend Chart
              Container(
                height: 300,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: const Color(0xFF141f18), border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Waste Trend (kg)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 24),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 1, getDrawingHorizontalLine: (value) => FlLine(color: Colors.white10, strokeWidth: 1, dashArray: [3, 3])),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40, getTitlesWidget: (val, meta) => Text(val.toStringAsFixed(0), style: const TextStyle(color: Colors.grey, fontSize: 11)))),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 22,
                                interval: 1,
                                getTitlesWidget: (val, meta) {
                                  if (val.toInt() >= 0 && val.toInt() < chartData.length) {
                                    return Text(chartData[val.toInt()].label, style: const TextStyle(color: Colors.grey, fontSize: 11));
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            _lineChartBarData(chartData, (d) => d.wet, const Color(0xFF2dd4bf)),
                            _lineChartBarData(chartData, (d) => d.dry, const Color(0xFFf59e0b)),
                            _lineChartBarData(chartData, (d) => d.recyclable, const Color(0xFF60a5fa)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Side-by-side Bar + Pie
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bar Chart
                  Expanded(
                    child: Container(
                      height: 300,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(color: const Color(0xFF141f18), border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Category Breakdown (kg)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
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
                                        if (val.toInt() >= 0 && val.toInt() < chartData.length) {
                                          return Padding(
                                              padding: const EdgeInsets.only(top: 8),
                                              child: Text(chartData[val.toInt()].label, style: const TextStyle(color: Colors.grey, fontSize: 11)));
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                  ),
                                ),
                                barGroups: List.generate(
                                  chartData.length,
                                  (i) => BarChartGroupData(
                                    x: i,
                                    barRods: [
                                      BarChartRodData(toY: chartData[i].wet, color: const Color(0xFF2dd4bf), width: 8, borderRadius: const BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3))),
                                      BarChartRodData(toY: chartData[i].dry, color: const Color(0xFFf59e0b), width: 8, borderRadius: const BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3))),
                                      BarChartRodData(toY: chartData[i].recyclable, color: const Color(0xFF60a5fa), width: 8, borderRadius: const BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Pie Chart
                  Expanded(
                    child: Container(
                      height: 300,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(color: const Color(0xFF141f18), border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Overall Composition', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                          const SizedBox(height: 24),
                          Expanded(
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 2,
                                centerSpaceRadius: 0,
                                sections: [
                                  if (stats.totalWet > 0) PieChartSectionData(color: const Color(0xFF2dd4bf), value: stats.totalWet, title: '${((stats.totalWet / stats.totalAll) * 100).toStringAsFixed(0)}%', radius: 80, titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                                  if (stats.totalDry > 0) PieChartSectionData(color: const Color(0xFFf59e0b), value: stats.totalDry, title: '${((stats.totalDry / stats.totalAll) * 100).toStringAsFixed(0)}%', radius: 80, titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                                  if (stats.totalRecyclable > 0) PieChartSectionData(color: const Color(0xFF60a5fa), value: stats.totalRecyclable, title: '${((stats.totalRecyclable / stats.totalAll) * 100).toStringAsFixed(0)}%', radius: 80, titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                                ],
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

              // Summary
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: const Color(0xFF141f18), border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Summary Metrics', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: _metricItem('Total Wet', '${stats.totalWet} kg', const Color(0xFF2dd4bf))),
                        const SizedBox(width: 16),
                        Expanded(child: _metricItem('Total Dry', '${stats.totalDry} kg', const Color(0xFFf59e0b))),
                        const SizedBox(width: 16),
                        Expanded(child: _metricItem('Total Recyclable', '${stats.totalRecyclable} kg', const Color(0xFF60a5fa))),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Colors.white10),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _metricItem('Overall Total', '${stats.totalAll} kg', const Color(0xFF4ade80))),
                        const SizedBox(width: 16),
                        Expanded(child: _metricItem('Daily Average', '${stats.avgDaily} kg/day', Colors.white)),
                        const SizedBox(width: 16),
                        Expanded(child: _metricItem('Per Capita', '${stats.perCapita} kg/person', Colors.white)),
                      ],
                    ),
                  ],
                ),
              )

            ],
          ),
        );
      },
    );
  }

  Widget _toggleBtn(String mode, String label) {
    bool active = _view == mode;
    return InkWell(
      onTap: () => setState(() => _view = mode),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: active ? const Color(0xFF4ade80) : Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
        child: Text(label, style: TextStyle(color: active ? const Color(0xFF0a120d) : Colors.grey.shade400, fontWeight: FontWeight.w500, fontSize: 14)),
      ),
    );
  }

  LineChartBarData _lineChartBarData(List<ChartData> data, double Function(ChartData) valueSelector, Color color) {
    return LineChartBarData(
      spots: List.generate(data.length, (i) => FlSpot(i.toDouble(), valueSelector(data[i]))),
      isCurved: true,
      color: color,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: color.withOpacity(0.15),
      ),
    );
  }

  Widget _metricItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }
}
