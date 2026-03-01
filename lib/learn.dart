import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'learn_data.dart';
import 'models.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  LearnArticle? _selectedArticle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Learn', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          const Text('Knowledge hub — segregation, composting, recycling, and sustainability.', style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 32),

          if (_selectedArticle != null)
            _buildArticleDetail()
          else
            _buildGrid(),
          
          if (_selectedArticle == null) ...[
            const SizedBox(height: 32),
            _buildQuickReference(),
          ]
        ],
      ),
    );
  }

  Widget _buildArticleDetail() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () => setState(() => _selectedArticle = null),
            icon: const Icon(LucideIcons.x, size: 16, color: Colors.grey),
            label: const Text('Close article', style: TextStyle(color: Colors.grey)),
            style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.centerLeft),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF141f18),
              border: Border.all(color: Colors.white12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_selectedArticle!.icon, style: const TextStyle(fontSize: 48)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF4ade80).withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(_selectedArticle!.category.toUpperCase(), style: const TextStyle(color: Color(0xFF4ade80), fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        const Icon(LucideIcons.clock, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('${_selectedArticle!.readTime} min read', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(_selectedArticle!.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(border: Border(left: BorderSide(color: const Color(0xFF4ade80).withOpacity(0.4), width: 3))),
                  child: Text(_selectedArticle!.summary, style: const TextStyle(color: Colors.grey, fontSize: 14, fontStyle: FontStyle.italic, height: 1.5)),
                ),
                const SizedBox(height: 24),
                Text(_selectedArticle!.content, style: const TextStyle(color: Color(0xFFd1d5db), fontSize: 15, height: 1.6)),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 200,
      ),
      itemCount: learnArticles.length,
      itemBuilder: (context, index) {
        final article = learnArticles[index];
        return InkWell(
          onTap: () => setState(() => _selectedArticle = article),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF141f18),
              border: Border.all(color: Colors.white12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.icon, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 12),
                Text(article.category.toUpperCase(), style: const TextStyle(color: Color(0xFF4ade80), fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(article.title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Expanded(child: Text(article.summary, style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.4), maxLines: 3, overflow: TextOverflow.ellipsis)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.clock, size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('${article.readTime} min', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    const Icon(LucideIcons.chevronRight, size: 16, color: Colors.grey),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickReference() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF141f18),
        border: Border.all(color: Colors.white12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quick Reference: What Goes Where?', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _quickRefCol(
                  'Wet (Biodegradable)',
                  ['Vegetable peels', 'Fruit scraps', 'Cooked food', 'Tea/coffee grounds', 'Garden cuttings', 'Eggshells'],
                  const Color(0xFF2dd4bf),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _quickRefCol(
                  'Dry Non-Recyclable',
                  ['Soiled plastic', 'Chips bags', 'Diapers/sanitary', 'Styrofoam', 'Ceramic/broken glass', 'Composite packaging'],
                  const Color(0xFFf59e0b),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _quickRefCol(
                  'Recyclable',
                  ['Clean PET bottles', 'Cardboard & paper', 'Aluminum cans', 'Glass bottles', 'Metal scraps', 'Clean HDPE plastic'],
                  const Color(0xFF60a5fa),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _quickRefCol(String title, List<String> items, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 4, height: 4,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Expanded(child: Text(item, style: const TextStyle(color: Colors.grey, fontSize: 12))),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
