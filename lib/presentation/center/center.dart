// ignore_for_file: deprecated_member_use, unnecessary_brace_in_string_interps, unnecessary_to_list_in_spreads, avoid_print

import 'package:flutter/material.dart';
class CenterPage extends StatelessWidget {
  const CenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مركز الإسعاف 140 - إدارة العمليات'),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // تخطيط متجاوب: شاشة كبيرة (ويب/سطح المكتب) أو شاشة صغيرة (جوال)
            bool isLargeScreen = constraints.maxWidth > 900;

            if (isLargeScreen) {
              return const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الجزء الأيمن: المحتوى الرئيسي (حالة المركز والمركبات)
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: _CenterMainContent(),
                    ),
                  ),
                  // الجزء الأيسر: الشريط الجانبي (المناوبات والإحصائيات والفلاتر)
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: _CenterSidebar(),
                    ),
                  ),
                ],
              );
            } else {
              return const SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _CenterMainContent(),
                    SizedBox(height: 20),
                    _CenterSidebar(), // الشريط الجانبي يوضع في الأسفل للشاشات الصغيرة
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _CenterMainContent extends StatelessWidget {
  const _CenterMainContent();

  final List<Map<String, dynamic>> centerVehicles = const [
    {'id': '104', 'type': 'AMB-A', 'status': 'في مهمة (أحمر)', 'driver': 'خالد محمد', 'eta': '15 دقيقة'},
    {'id': '102', 'type': 'AMB-B', 'status': 'متاح في المركز', 'driver': 'يوسف علي', 'eta': 'متاح'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مركبات المركز 140 العاملة على الأرض',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: centerVehicles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3.5,
          ),
          itemBuilder: (context, index) {
            final vehicle = centerVehicles[index];
            return _VehicleStatusCard(vehicle: vehicle);
          },
        ),
        const SizedBox(height: 30),
        Text(
          'تتبع حي للمركبات',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: const Text(
            'خريطة تظهر موقع المركبة 104 (في مهمة) و 102 (في المركز)',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
      ],
    );
  }
}

class _VehicleStatusCard extends StatelessWidget {
  final Map<String, dynamic> vehicle;
  const _VehicleStatusCard({required this.vehicle});

  Color _getStatusColor(String status) {
    if (status.contains('مهمة') || status.contains('أحمر')) return Colors.red;
    if (status.contains('متاح')) return Colors.green;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(vehicle['status']);

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: statusColor.withOpacity(0.5), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'مركبة ${vehicle['id']} (${vehicle['type']})',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'السائق: ${vehicle['driver']}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  vehicle['status'],
                  style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  'الوصول المتوقع: ${vehicle['eta']}',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
            // زر الخيارات
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // منطق عرض خيارات المركبة (تتبع، تقرير، تغيير حالة)
              },
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 3. الشريط الجانبي لمركز 140 (المناوبات والإحصائيات والفلاتر)
// -----------------------------------------------------------------

class _CenterSidebar extends StatelessWidget {
  const _CenterSidebar();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // أ. المناوبون القادمون وتسجيل الدخول
        const _UpcomingShiftCard(),
        const SizedBox(height: 20),

        // ب. مرشحات الإحصائيات (مهمات ومناوبات)
        const _CenterStatsCard(),
        const SizedBox(height: 20),

        // ت. مرشحات المهام (الفلاتر من الداشبورد)
        const _CenterMissionFilters(),
      ],
    );
  }
}

// -----------------------------------------------------------------
// 4. مكونات المناوبات وتسجيل الدخول
// -----------------------------------------------------------------

class _UpcomingShiftCard extends StatelessWidget {
  const _UpcomingShiftCard();

  final List<String> upcomingTeam = const ['أحمد فهد', 'سارة ناصر', 'فريق دعم (أ)'];
  final String nextShiftTime = '22:00';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🗓️ المناوبة القادمة (${nextShiftTime})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
            ),
            const Divider(),
            ...upcomingTeam.map((name) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  const Icon(Icons.person, size: 18, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(name),
                ],
              ),
            )).toList(),
            const SizedBox(height: 15),

            // زر تسجيل دخول المناوبة
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تسجيل دخول المناوبين بنجاح', textDirection: TextDirection.rtl)));
              },
              icon: const Icon(Icons.login),
              label: const Text('تسجيل دخول المناوبة'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 5. مكون الإحصائيات (المهمات والمناوبات اليومية/الشهرية)
// -----------------------------------------------------------------

class _CenterStatsCard extends StatefulWidget {
  const _CenterStatsCard();

  @override
  State<_CenterStatsCard> createState() => _CenterStatsCardState();
}

class _CenterStatsCardState extends State<_CenterStatsCard> {
  String _period = 'currentDay';
  final Map<String, dynamic> stats = const {
    'currentDay': {'missions': 4, 'shifts': 2},
    'currentWeek': {'missions': 25, 'shifts': 14},
    'currentMonth': {'missions': 110, 'shifts': 60},
  };

  @override
  Widget build(BuildContext context) {
    final currentStats = stats[_period] ?? {'missions': 0, 'shifts': 0};

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📊 إحصائيات المركز', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'الفترة الزمنية',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              value: _period,
              items: const [
                {'value': 'currentDay', 'label': 'اليوم الحالي'},
                {'value': 'currentWeek', 'label': 'هذا الأسبوع'},
                {'value': 'currentMonth', 'label': 'هذا الشهر'},
              ].map((item) => DropdownMenuItem(value: item['value'], child: Text(item['label']!))).toList(),
              onChanged: (value) => setState(() => _period = value!),
            ),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatBox(context, 'إجمالي المهمات', currentStats['missions'], Colors.deepOrange),
                _buildStatBox(context, 'عدد المناوبات', currentStats['shifts'], Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(BuildContext context, String title, int count, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text('$count', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: color.withOpacity(0.8))),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// 6. مكون مرشحات المهام (الفلاتر)
// -----------------------------------------------------------------

class _CenterMissionFilters extends StatefulWidget {
  const _CenterMissionFilters();

  @override
  __CenterMissionFiltersState createState() => __CenterMissionFiltersState();
}

class __CenterMissionFiltersState extends State<_CenterMissionFilters> {
  String? selectedCaseCode;
  String? selectedCaseType;

  // يتم تثبيت القطاع على 140 لمركز الإسعاف
  final String selectedSector = '140';

  final List<String> caseCodes = const ['أحمر (خطر)', 'أصفر (متوسط)', 'أخضر (بسيط)', 'أسود (لم يتم النقل)'];
  final List<String> caseTypes = const ['حادث سير', 'أمراض قلبية', 'شك اشتباه', 'أخرى'];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🔍 مرشحات مهمات المركز', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(),

            // عرض ثابت للقطاع (لا يمكن تغييره)
            _buildInfoBox('القطاع المحدد', selectedSector, Colors.blueGrey),
            const SizedBox(height: 12),

            // مرشح كود الحالة
            _buildDropdownFilter(
              label: 'كود الحالة',
              value: selectedCaseCode,
              items: caseCodes,
              onChanged: (String? newValue) => setState(() => selectedCaseCode = newValue),
            ),
            const SizedBox(height: 12),

            // مرشح نوع الحادث
            _buildDropdownFilter(
              label: 'نوع الحادث',
              value: selectedCaseType,
              items: caseTypes,
              onChanged: (String? newValue) => setState(() => selectedCaseType = newValue),
            ),
            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                // منطق تطبيق الفلاتر على بيانات المهمات للمركز 140
                print('تطبيق الفلتر: الكود $selectedCaseCode، النوع $selectedCaseType');
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تطبيق الفلاتر لعرض المهمات الخاصة بالمركز 140', textDirection: TextDirection.rtl)));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('تطبيق الفلترة'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ),
      ],
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
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
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
}