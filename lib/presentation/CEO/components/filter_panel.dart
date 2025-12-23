import 'package:flutter/material.dart';


class FilterPanel extends StatefulWidget {
  const FilterPanel({super.key});

  @override
  FilterPanelState createState() => FilterPanelState();
}

class FilterPanelState extends State<FilterPanel> {
  String? selectedSector;
  String? selectedCaseCode;
  String? selectedCaseType;
  final Map<String, int> statusMissionCounts = {
    'أحمر (خطر)': 5,
    'أصفر (متوسط)': 12,
    'أسود (لم يتم النقل)': 3,
    'الكل': 20,
  };

  final List<String> sectors = const ['140', '100', '110', '115'];
  final List<String> caseCodes = const ['أحمر (خطر)', 'أصفر (متوسط)', 'أسود (لم يتم النقل)', 'الكل'];
  final List<String> caseTypes = const [
    'حادث سير',
    'حريق',
    'كسر',
    'أمراض قلبية',
    'أمراض عصبية',
    'أمراض هضمية',
    'آخر'
  ];

  Color _getColor(String status) {
    if (status.contains('أحمر')) return Colors.red;
    if (status.contains('أصفر')) return Colors.amber.shade800;
    if (status.contains('أسود')) return Colors.black87;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Theme.of(context).shadowColor.withOpacity(0.1), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('فلترة الحالات', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const Divider(),

          _buildDropdownFilter(
            label: 'القطاع',
            value: selectedSector,
            items: sectors,
            onChanged: (String? newValue) => setState(() => selectedSector = newValue),
          ),
          const SizedBox(height: 12),

          _buildDropdownFilter(
            label: 'كود الحالة',
            value: selectedCaseCode,
            items: caseCodes,
            onChanged: (String? newValue) => setState(() => selectedCaseCode = newValue),
          ),
          const SizedBox(height: 12),

          _buildDropdownFilter(
            label: 'نوع الحادث',
            value: selectedCaseType,
            items: caseTypes,
            onChanged: (String? newValue) => setState(() => selectedCaseType = newValue),
          ),
          const SizedBox(height: 12),

          _buildTextFieldFilter(
            label: 'التاريخ',
            hint: 'اختر التاريخ',
            keyboardType: TextInputType.datetime,
            icon: Icons.calendar_month,
          ),

          const Divider(height: 30),
          const Text('حالة الأولوية / عدد المهمات', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),

          ...statusMissionCounts.entries.map((entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _getColor(entry.key),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(entry.key, style: TextStyle(color: _getColor(entry.key), fontWeight: FontWeight.bold)),
                  ],
                ),
                Text('${entry.value} مهمات', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          )),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              backgroundColor: Theme.of(context).primaryColor, // اللون الأحمر
              foregroundColor: Colors.white,
            ),
            child: const Text('تطبيق الفلتر', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, textDirection: TextDirection.rtl, style: const TextStyle(fontWeight: FontWeight.w600)),
        DropdownButtonFormField<String>(
          initialValue: value,
          decoration: InputDecoration(
            hintText: 'اختر $label',
            border: const OutlineInputBorder(),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          ),
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, textDirection: TextDirection.rtl),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildTextFieldFilter({
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, textDirection: TextDirection.rtl, style: const TextStyle(fontWeight: FontWeight.w600)),
        TextField(
          textAlign: TextAlign.right,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            isDense: true,
            suffixIcon: icon != null ? Icon(icon) : null,
          ),
        ),
      ],
    );
  }
}
