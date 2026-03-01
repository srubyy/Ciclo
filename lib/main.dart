import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models.dart';
import 'landing.dart';
import 'dashboard.dart';

import 'log.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WasteStore(),
      child: const CicloApp(),
    ),
  );
}

class CicloApp extends StatelessWidget {
  const CicloApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ciclo Waste Intelligence',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0a120d),
        primaryColor: const Color(0xFF4ade80),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF4ade80),
          secondary: Color(0xFF2dd4bf),
          surface: Color(0xFF141f18),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingScreen(),
        '/app': (context) => const AppLayout(),
      },
    );
  }
}

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const DashboardScreen(),
    const LogScreen(),
    const Center(child: Text('Analytics')),
    const Center(child: Text('Tips')),
    const Center(child: Text('Learn')),
    const Center(child: Text('Community')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: Colors.white12)),
            ),
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
                _navItem(0, LucideIcons.home, 'Dashboard'),
                _navItem(1, LucideIcons.plusCircle, 'Log'),
                _navItem(2, LucideIcons.barChart2, 'Analytics'),
                _navItem(3, LucideIcons.lightbulb, 'Tips'),
                _navItem(4, LucideIcons.bookOpen, 'Learn'),
                _navItem(5, LucideIcons.users, 'Community'),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text('SDG 12 · Responsible Consumption\nVESIT · Dept. of IT · 2025-26', style: TextStyle(color: Colors.white38, fontSize: 10, height: 1.5)),
                )
              ],
            ),
          ),
          // Main content
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final isActive = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4ade80).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: isActive ? const Color(0xFF4ade80) : Colors.grey),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.grey, fontSize: 14, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
