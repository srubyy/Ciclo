import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a120d),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.white12))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ciclo', style: TextStyle(color: Color(0xFF4ade80), fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('WASTE INTELLIGENCE', style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 2)),
                    ],
                  ),
                ),
                _navItem(LucideIcons.home, 'Home', true),
                _navItem(LucideIcons.barChart2, 'Dashboard', false),
                _navItem(LucideIcons.plusCircle, 'Log', false),
                _navItem(LucideIcons.activity, 'Analytics', false),
                _navItem(LucideIcons.lightbulb, 'Tips', false),
                _navItem(LucideIcons.bookOpen, 'Learn', false),
                _navItem(LucideIcons.users, 'Community', false),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text('SDG 12 · Responsible Consumption\nVESIT · Dept. of IT · 2025-26', style: TextStyle(color: Colors.white38, fontSize: 10, height: 1.5)),
                )
              ],
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(border: Border.all(color: const Color(0xFF4ade80).withOpacity(0.3)), borderRadius: BorderRadius.circular(20), color: const Color(0xFF4ade80).withOpacity(0.1)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(radius: 4, backgroundColor: Color(0xFF4ade80)),
                        SizedBox(width: 8),
                        Text('SDG 12 · RESPONSIBLE CONSUMPTION', style: TextStyle(color: Color(0xFF4ade80), fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, height: 1.1, color: Colors.white),
                      children: [
                        TextSpan(text: 'Know your\n'),
                        TextSpan(text: 'waste', style: TextStyle(color: Color(0xFF4ade80))),
                        TextSpan(text: ', change\n'),
                        TextSpan(text: 'your '),
                        TextSpan(text: 'world.', style: TextStyle(color: Color(0xFF4ade80))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Ciclo bridges the household awareness gap — track daily waste\nacross wet, dry, and recyclable streams. Visualize your footprint.\nReduce it.', style: TextStyle(fontSize: 18, color: Colors.grey, height: 1.5)),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/app'),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4ade80), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        child: const Row(
                          children: [
                            Text('Start Logging', style: TextStyle(color: Color(0xFF0a120d), fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Icon(LucideIcons.arrowRight, color: Color(0xFF0a120d), size: 20),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/app'),
                        style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        child: const Row(
                          children: [
                            Text('View Dashboard', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Icon(LucideIcons.barChart2, color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  Row(
                    children: [
                      _stat('12+', 'Households Surveyed'),
                      const SizedBox(width: 48),
                      _stat('5', 'Cities Studied'),
                      const SizedBox(width: 48),
                      _stat('80%', 'Awareness Gap'),
                      const SizedBox(width: 48),
                      _stat('3', 'SDGs Supported'),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF4ade80))),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: isActive ? const Color(0xFF4ade80).withOpacity(0.1) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, size: 20, color: isActive ? const Color(0xFF4ade80) : Colors.grey),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.grey, fontSize: 14, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal)),
        ],
      ),
    );
  }
}
