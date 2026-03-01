import 'models.dart';

List<WasteTip> generateTips(WasteStats stats) {
  final List<WasteTip> tips = [];

  if (stats.dryPercentage > 30) {
    tips.add(WasteTip(
      id: 't1',
      category: 'dry',
      title: 'Switch to Reusable Bags',
      description: 'Your dry waste exceeds 30% of total output. Replace single-use plastic bags with cloth or jute bags for daily shopping.',
      impact: 'high',
      icon: '🛍️',
    ));
  }
  if (stats.dryPercentage > 20) {
    tips.add(WasteTip(
      id: 't2',
      category: 'dry',
      title: 'Refuse Single-Use Plastics',
      description: 'Carry a reusable water bottle and refuse plastic straws, cutlery, and wrappers when ordering or shopping.',
      impact: 'high',
      icon: '♻️',
    ));
  }
  if (stats.wetPercentage > 50) {
    tips.add(WasteTip(
      id: 't3',
      category: 'wet',
      title: 'Start Home Composting',
      description: 'Your wet waste is high. Start a compost bin with kitchen scraps — it converts food waste into rich fertilizer.',
      impact: 'high',
      icon: '🌱',
    ));
  }
  if (stats.wetPercentage > 40) {
    tips.add(WasteTip(
      id: 't4',
      category: 'wet',
      title: 'Plan Meals in Advance',
      description: 'Reduce food waste by planning weekly meals. Buy only what you need to avoid spoilage and excess cooking.',
      impact: 'medium',
      icon: '🥗',
    ));
  }
  if (stats.recyclablePercentage < 15 && stats.totalAll > 0) {
    tips.add(WasteTip(
      id: 't5',
      category: 'recyclable',
      title: 'Improve Segregation Habits',
      description: 'Your recyclable capture rate is low. Clean plastic bottles, paper, and glass before placing in the recyclables bin.',
      impact: 'medium',
      icon: '🔄',
    ));
  }
  if (stats.avgDaily > 1.5) {
    tips.add(WasteTip(
      id: 't6',
      category: 'general',
      title: 'Buy in Bulk, Reduce Packaging',
      description: 'Your daily average is above 1.5 kg. Purchasing staples in bulk reduces packaging waste significantly.',
      impact: 'medium',
      icon: '🏪',
    ));
  }
  if (stats.perCapita > 0.5) {
    tips.add(WasteTip(
      id: 't7',
      category: 'general',
      title: 'Adopt the Zero-Waste 5Rs',
      description: 'Per capita waste is high. Practice Refuse, Reduce, Reuse, Recycle, and Rot (compost) in daily life.',
      impact: 'high',
      icon: '🌍',
    ));
  }

  // Always include a few general tips
  tips.addAll([
    WasteTip(
      id: 't8',
      category: 'general',
      title: 'Use Both Sides of Paper',
      description: 'Before recycling paper, use both sides for notes or drafts. Small changes accumulate into meaningful reduction.',
      impact: 'low',
      icon: '📄',
    ),
    WasteTip(
      id: 't9',
      category: 'wet',
      title: 'Store Food Properly',
      description: 'Use airtight containers in the fridge to extend food shelf life and prevent unnecessary spoilage.',
      impact: 'low',
      icon: '🥡',
    ),
    WasteTip(
      id: 't10',
      category: 'recyclable',
      title: 'Rinse Before Recycling',
      description: 'Contaminated recyclables (soiled plastics, greasy paper) end up in landfills. Always rinse containers before recycling.',
      impact: 'medium',
      icon: '🚿',
    ),
  ]);

  return tips;
}
