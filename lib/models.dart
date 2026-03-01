import 'dart:math';
import 'package:flutter/foundation.dart';

class WasteEntry {
  final String id;
  final String date;
  final double wet;
  final double dry;
  final double recyclable;
  final String? notes;

  WasteEntry({
    required this.id,
    required this.date,
    required this.wet,
    required this.dry,
    required this.recyclable,
    this.notes,
  });
}

class UserProfile {
  String name;
  int familySize;
  String location;
  bool onboarded;

  UserProfile({
    this.name = '',
    this.familySize = 4,
    this.location = 'Mumbai',
    this.onboarded = false,
  });
}

class WasteStats {
  final double totalWet;
  final double totalDry;
  final double totalRecyclable;
  final double totalAll;
  final double avgDaily;
  final double perCapita;
  final double dryPercentage;
  final double wetPercentage;
  final double recyclablePercentage;

  WasteStats({
    required this.totalWet,
    required this.totalDry,
    required this.totalRecyclable,
    required this.totalAll,
    required this.avgDaily,
    required this.perCapita,
    required this.dryPercentage,
    required this.wetPercentage,
    required this.recyclablePercentage,
  });
}

class ChartData {
  final String label;
  final double wet;
  final double dry;
  final double recyclable;

  ChartData({required this.label, required this.wet, required this.dry, required this.recyclable});
}

class WasteTip {
  final String id;
  final String category;
  final String title;
  final String description;
  final String impact;
  final String icon;

  WasteTip({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.impact,
    required this.icon,
  });
}

class LearnArticle {
  final String id;
  final String title;
  final String category;
  final String summary;
  final String content;
  final String icon;
  final int readTime;

  LearnArticle({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    required this.content,
    required this.icon,
    required this.readTime,
  });
}

class WasteStore extends ChangeNotifier {
  List<WasteEntry> entries = [];
  UserProfile profile = UserProfile();

  String _generateId() {
    return Random().nextInt(999999).toString();
  }

  void addEntry(WasteEntry entry) {
    entries.insert(
        0,
        WasteEntry(
          id: _generateId(),
          date: entry.date,
          wet: entry.wet,
          dry: entry.dry,
          recyclable: entry.recyclable,
          notes: entry.notes,
        ));
    notifyListeners();
  }

  void removeEntry(String id) {
    entries.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  WasteStats getStats() {
    if (entries.isEmpty) {
      return WasteStats(
          totalWet: 0,
          totalDry: 0,
          totalRecyclable: 0,
          totalAll: 0,
          avgDaily: 0,
          perCapita: 0,
          dryPercentage: 0,
          wetPercentage: 0,
          recyclablePercentage: 0);
    }

    double wet = entries.fold(0, (s, e) => s + e.wet);
    double dry = entries.fold(0, (s, e) => s + e.dry);
    double rec = entries.fold(0, (s, e) => s + e.recyclable);
    double total = wet + dry + rec;
    double avg = total / entries.length;
    double pc = avg / profile.familySize;

    return WasteStats(
      totalWet: double.parse(wet.toStringAsFixed(2)),
      totalDry: double.parse(dry.toStringAsFixed(2)),
      totalRecyclable: double.parse(rec.toStringAsFixed(2)),
      totalAll: double.parse(total.toStringAsFixed(2)),
      avgDaily: double.parse(avg.toStringAsFixed(2)),
      perCapita: double.parse(pc.toStringAsFixed(2)),
      dryPercentage: total > 0 ? double.parse(((dry / total) * 100).toStringAsFixed(1)) : 0,
      wetPercentage: total > 0 ? double.parse(((wet / total) * 100).toStringAsFixed(1)) : 0,
      recyclablePercentage: total > 0 ? double.parse(((rec / total) * 100).toStringAsFixed(1)) : 0,
    );
  }

  List<ChartData> getWeeklyData() {
    // Generate dummy weekly data based on entries if entries exist, else return empty
    if (entries.isEmpty) return [];
    
    // Group by last 7 days roughly for demo
    List<ChartData> data = [];
    final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    for (int i = 0; i < 7; i++) {
        // Just spread the existing averages randomly to fake real chart data
        double base = entries.isNotEmpty ? (entries.fold(0.0, (s, e) => s + e.wet) / entries.length) : 0;
        data.add(ChartData(
            label: labels[i],
            wet: double.parse((base * (0.8 + Random().nextDouble() * 0.4)).toStringAsFixed(2)),
            dry: double.parse((base * (0.5 + Random().nextDouble() * 0.4)).toStringAsFixed(2)),
            recyclable: double.parse((base * (0.2 + Random().nextDouble() * 0.3)).toStringAsFixed(2)),
        ));
    }
    return data;
  }

  List<ChartData> getMonthlyData() {
    if (entries.isEmpty) return [];
    
    List<ChartData> data = [];
    final labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
    
    for (int i = 0; i < 4; i++) {
        double base = entries.isNotEmpty ? (entries.fold(0.0, (s, e) => s + e.wet) / entries.length) * 7 : 0;
        data.add(ChartData(
            label: labels[i],
            wet: double.parse((base * (0.8 + Random().nextDouble() * 0.4)).toStringAsFixed(2)),
            dry: double.parse((base * (0.5 + Random().nextDouble() * 0.4)).toStringAsFixed(2)),
            recyclable: double.parse((base * (0.2 + Random().nextDouble() * 0.3)).toStringAsFixed(2)),
        ));
    }
    return data;
  }

  void seedDemoData() {
    entries.clear();
    for (int i = 29; i >= 0; i--) {
      DateTime d = DateTime.now().subtract(Duration(days: i));
      String dateStr = "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
      double wet = 0.4 + Random().nextDouble() * 0.8;
      double dry = 0.2 + Random().nextDouble() * 0.6;
      double rec = 0.1 + Random().nextDouble() * 0.4;
      entries.add(WasteEntry(id: _generateId(), date: dateStr, wet: double.parse(wet.toStringAsFixed(2)), dry: double.parse(dry.toStringAsFixed(2)), recyclable: double.parse(rec.toStringAsFixed(2))));
    }
    entries = entries.reversed.toList();
    profile = UserProfile(name: 'Demo User', familySize: 4, location: 'Thane', onboarded: true);
    notifyListeners();
  }
}
