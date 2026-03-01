import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'tips_util.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WasteStore>(
      builder: (context, store, child) {
        if (store.entries.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('💡', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 24),
                const Text('Log some waste data first to receive personalized tips.', style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {}, // Handled by AppLayout
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4ade80), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text('Log Waste', style: TextStyle(color: Color(0xFF0a120d), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        }

        final stats = store.getStats();
        final tips = generateTips(stats);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tips', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              const Text('Personalized recommendations based on your waste data', style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 32),

              // Composition Summary Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: const Color(0xFF141f18), border: Border.all(color: Colors.white12), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('YOUR WASTE PROFILE', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _bar('Wet', stats.wetPercentage, const Color(0xFF2dd4bf))),
                        const SizedBox(width: 16),
                        Expanded(child: _bar('Dry', stats.dryPercentage, const Color(0xFFf59e0b))),
                        const SizedBox(width: 16),
                        Expanded(child: _bar('Recyclable', stats.recyclablePercentage, const Color(0xFF60a5fa))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tips Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  mainAxisExtent: 180, // fixed height for tip cards
                ),
                itemCount: tips.length,
                itemBuilder: (context, index) {
                  return _tipCard(tips[index]);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _bar(String label, double pct, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text('$pct%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 8),
        Container(
          height: 4,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)),
          child: Row(
            children: [
              Expanded(flex: (pct * 10).toInt(), child: Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)))),
              Expanded(flex: pct < 100 ? ((100 - pct) * 10).toInt() : 0, child: const SizedBox()),
            ],
          ),
        )
      ],
    );
  }

  Widget _tipCard(WasteTip tip) {
    Color impactBorder;
    Color impactBg;
    Color impactText;

    if (tip.impact == 'high') {
      impactBorder = Colors.red.withOpacity(0.3);
      impactBg = Colors.red.withOpacity(0.08);
      impactText = Colors.red.shade400;
    } else if (tip.impact == 'medium') {
      impactBorder = Colors.yellow.withOpacity(0.3);
      impactBg = Colors.yellow.withOpacity(0.08);
      impactText = Colors.yellow.shade400;
    } else {
      impactBorder = Colors.green.withOpacity(0.3);
      impactBg = Colors.green.withOpacity(0.08);
      impactText = Colors.green.shade400;
    }

    Color catColor;
    String catLabel;
    if (tip.category == 'wet') {
      catColor = const Color(0xFF2dd4bf);
      catLabel = '🫧 Wet Waste';
    } else if (tip.category == 'dry') {
      catColor = const Color(0xFFf59e0b);
      catLabel = '🧴 Dry Waste';
    } else if (tip.category == 'recyclable') {
      catColor = const Color(0xFF60a5fa);
      catLabel = '♻️ Recyclable';
    } else {
      catColor = const Color(0xFF4ade80);
      catLabel = '🌍 General';
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF141f18),
        border: Border.all(color: Colors.white12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tip.icon, style: const TextStyle(fontSize: 24)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: impactBg, border: Border.all(color: impactBorder), borderRadius: BorderRadius.circular(12)),
                child: Text('${tip.impact} impact'.toUpperCase(), style: TextStyle(color: impactText, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(tip.title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Expanded(child: Text(tip.description, style: const TextStyle(color: Colors.white60, fontSize: 12, height: 1.4), maxLines: 3, overflow: TextOverflow.ellipsis)),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white10))),
            child: Text(catLabel.toUpperCase(), style: TextStyle(color: catColor, fontSize: 10, letterSpacing: 1.5)),
          )
        ],
      ),
    );
  }
}
