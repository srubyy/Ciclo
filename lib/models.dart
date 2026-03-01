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
