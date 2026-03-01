import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'models.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({Key? key}) : super(key: key);

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final _wetController = TextEditingController();
  final _dryController = TextEditingController();
  final _recyclableController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _success = false;

  @override
  void dispose() {
    _wetController.dispose();
    _dryController.dispose();
    _recyclableController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final wet = double.tryParse(_wetController.text) ?? 0.0;
    final dry = double.tryParse(_dryController.text) ?? 0.0;
    final recyclable = double.tryParse(_recyclableController.text) ?? 0.0;

    if (wet + dry + recyclable == 0) return;

    final dateStr = "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

    Provider.of<WasteStore>(context, listen: false).addEntry(
      WasteEntry(
        id: '', // Generated in store
        date: dateStr,
        wet: wet,
        dry: dry,
        recyclable: recyclable,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      ),
    );

    _wetController.clear();
    _dryController.clear();
    _recyclableController.clear();
    _notesController.clear();
    setState(() => _selectedDate = DateTime.now());

    setState(() => _success = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _success = false);
    });
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF4ade80),
              onPrimary: Color(0xFF0a120d),
              surface: Color(0xFF141f18),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<WasteStore>(context);
    final recent = store.entries.take(10).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Log Waste', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          const Text("Record today's household waste — wet, dry & recyclable.", style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 32),
          
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Form Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: const Color(0xFF141f18), border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('DATE', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: _pickDate,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}",
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Inputs Row
                        Row(
                          children: [
                            Expanded(child: _wasteInput('🫧 Wet', 'Biodegradable', _wetController, const Color(0xFF2dd4bf))),
                            const SizedBox(width: 12),
                            Expanded(child: _wasteInput('🧴 Dry', 'Non-recyclable', _dryController, const Color(0xFFf59e0b))),
                            const SizedBox(width: 12),
                            Expanded(child: _wasteInput('♻️ Recyclable', 'Clean plastics', _recyclableController, const Color(0xFF60a5fa))),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        const Text('NOTES (OPTIONAL)', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _notesController,
                          cursorColor: const Color(0xFF4ade80),
                          decoration: InputDecoration(
                            hintText: 'e.g. Extra plastic from deliveries...',
                            hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.3),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white10)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white10)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: const Color(0xFF4ade80).withOpacity(0.5))),
                          ),
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                        
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _handleSubmit,
                            icon: Icon(_success ? LucideIcons.check : LucideIcons.plusCircle, size: 18, color: _success ? Colors.white : const Color(0xFF0a120d)),
                            label: Text(_success ? 'Logged Successfully!' : 'Log Waste Entry', style: TextStyle(color: _success ? Colors.white : const Color(0xFF0a120d), fontWeight: FontWeight.bold, fontSize: 14)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _success ? Colors.green : const Color(0xFF4ade80),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Tip
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF141f18), border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Text('💡', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Tip: Estimate is fine', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
                              SizedBox(height: 2),
                              Text('Use a kitchen scale if available, or estimate — 1 full kitchen bin ≈ 0.5–1 kg wet waste.', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  
                  // Recent Logs
                  if (recent.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    const Text('Recent Logs', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(height: 12),
                    ...recent.map((entry) => _logItem(context, entry, store)),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _wasteInput(String label, String hint, TextEditingController controller, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          cursorColor: accent,
          decoration: InputDecoration(
            hintText: '0.00',
            hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            filled: true,
            fillColor: Colors.black.withOpacity(0.3),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white10)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white10)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: accent.withOpacity(0.5))),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 6),
        Text('$hint · kg', style: const TextStyle(fontSize: 10, color: Colors.white38)),
      ],
    );
  }

  Widget _logItem(BuildContext context, WasteEntry entry, WasteStore store) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF141f18), border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.date, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                if (entry.notes != null && entry.notes!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(entry.notes!, style: const TextStyle(color: Colors.grey, fontSize: 12), overflow: TextOverflow.ellipsis),
                ]
              ],
            ),
          ),
          Row(
            children: [
              _badge('wet', entry.wet, const Color(0xFF2dd4bf)),
              const SizedBox(width: 6),
              _badge('dry', entry.dry, const Color(0xFFf59e0b)),
              const SizedBox(width: 6),
              _badge('rec', entry.recyclable, const Color(0xFF60a5fa)),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(LucideIcons.trash2, size: 14, color: Colors.grey),
                onPressed: () => store.removeEntry(entry.id),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                hoverColor: Colors.red.withOpacity(0.1),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _badge(String type, double value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          Text('${value}kg', style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
