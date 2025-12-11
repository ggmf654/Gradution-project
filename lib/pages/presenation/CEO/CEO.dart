// ----------------------------------------------------
// ملف Flutter متكامل: لوحة التحكم مع التنقل بالمسارات
// ----------------------------------------------------

// ignore_for_file: deprecated_member_use, unnecessary_to_list_in_spreads, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';

// ------------------------------------------
// 1. إدارة الحالة (Dark/Light Mode)
// ------------------------------------------

/// ValueNotifier لإدارة حالة الوضع الليلي/النهاري
final ValueNotifier<bool> isDarkMode = ValueNotifier(false);

// ------------------------------------------
// 2. شاشة Overview Dashboard الرئيسية - (تم التعديل لإضافة المسارات)
// ------------------------------------------

class OverviewDashboardScreen extends StatelessWidget {
  const OverviewDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, isDark, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // دعم RTL
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'EORMS Dashboard',
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.red,
              primaryColor: Colors.red.shade700,
              scaffoldBackgroundColor: Colors.grey.shade100,
              cardColor: Colors.white,
              appBarTheme: AppBarTheme(backgroundColor: Colors.red.shade700, foregroundColor: Colors.white),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.red,
              primaryColor: Colors.red.shade900,
              scaffoldBackgroundColor: Colors.grey.shade900,
              cardColor: Colors.grey.shade800,
              appBarTheme: AppBarTheme(backgroundColor: Colors.red.shade900, foregroundColor: Colors.white),
            ),
            
            // ⭐ التعديل الرئيسي: تحديد المسارات (Routes)
            initialRoute: '/dashboard/overview',
            routes: {
              // شاشة النظرة العامة
              '/dashboard/overview': (context) => const _DashboardBody(),
              // شاشات التنقل المطلوبة
              '/dashboard/fleet': (context) => const FleetMonitoringScreen(),
              '/dashboard/exchange': (context) => const ShiftExchangeScreen(),
              
              // شاشات وهمية لتجنب الأخطاء في باقي الأزرار
              '/dashboard/reports': (context) => const PlaceholderScreen(title: 'قائمة البلاغات'),
              '/dashboard/shifts': (context) => const PlaceholderScreen(title: 'إدارة المناوبات'),
              '/dashboard/schedule': (context) => const PlaceholderScreen(title: 'توزيع الجدول'),
              '/dashboard/settings': (context) => const PlaceholderScreen(title: 'الإعدادات'),
            },
            
            // يجب أن يكون initialRoute معرفًا كمسار
            // أو يمكن استخدام home كإجراء احتياطي
            home: const _DashboardBody(), 
          ),
        );
      },
    );
  }
}

// ------------------------------------------
// 3. هيكل الجسم الرئيسي المتجاوب
// ------------------------------------------

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم'),
        // زر التبديل بين الوضعين في الـ AppBar للشاشات الصغيرة
        actions: [
          IconButton(
            // يجب أن نستخدم ValueListenableBuilder هنا لتحديث الرمز،
            // لكن لتبسيط الكود سنعتمد على إعادة بناء واجهة المستخدم عند النقر
            icon: Icon(isDarkMode.value ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              isDarkMode.value = !isDarkMode.value;
            },
          ),
        ],
      ),
      drawer: const _DashboardSidebar(), // الشريط الجانبي للموبايل

      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 900;

          if (isLargeScreen) {
            // تخطيط الشاشات الكبيرة (Web/Desktop)
            return const Row(
              children: [
                _DashboardSidebar(), // الشريط الجانبي ثابت
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: _MainContent(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                    child: _FilterPanel(), // لوحة الفلاتر
                  ),
                ),
              ],
            );
          } else {
            // تخطيط الشاشات الصغيرة (Mobile/Tablet)
            return const SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _MainContent(isMobile: true),
                  SizedBox(height: 20),
                  _FilterPanel(), // لوحة الفلاتر في الأسفل
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// ------------------------------------------
// 4. الشريط الجانبي (Sidebar) - (تم التعديل لتفعيل التنقل)
// ------------------------------------------

class _DashboardSidebar extends StatelessWidget {
  const _DashboardSidebar();

  @override
  Widget build(BuildContext context) {
    // قائمة العناصر بالمسارات المحددة
    final List<Map<String, dynamic>> navItems = [
      {'name': 'نظرة عامة (Overview)', 'icon': Icons.home, 'active': true, 'route': '/dashboard/overview'},
      {'name': 'قائمة البلاغات', 'icon': Icons.list_alt, 'active': false, 'route': '/dashboard/reports'},
      {'name': 'مراقبة الأسطول', 'icon': Icons.pin_drop, 'active': false, 'route': '/dashboard/fleet'},
      {'name': 'إدارة المناوبات', 'icon': Icons.schedule, 'active': false, 'route': '/dashboard/shifts'},
      {'name': 'توزيع الجدول', 'icon': Icons.table_chart, 'active': false, 'route': '/dashboard/schedule'},
      {'name': 'طلبات التبديل', 'icon': Icons.notifications, 'active': false, 'route': '/dashboard/exchange', 'notificationCount': 3},
      {'name': 'الإعدادات', 'icon': Icons.settings, 'active': false, 'route': '/dashboard/settings'},
    ];

    return Drawer(
      elevation: 5,
      child: Column(
        children: [
          DrawerHeader(
            child: Text('EORMS', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 28, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: navItems.length,
              itemBuilder: (context, index) {
                final item = navItems[index];
                return Container(
                  decoration: item['active']
                      ? BoxDecoration(
                          // اللون الأحمر بناءً على الثيم
                          border: Border(right: BorderSide(color: Theme.of(context).primaryColor, width: 4.0)),
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                        )
                      : null,
                  child: ListTile(
                    leading: Icon(item['icon'] as IconData),
                    title: Text(item['name'] as String, textDirection: TextDirection.rtl),
                    trailing: item['notificationCount'] != null
                        ? Chip(
                            label: Text('${item['notificationCount']}', style: const TextStyle(color: Colors.white)),
                            backgroundColor: Colors.red,
                          )
                        : null,
                    onTap: () {
                      // ⭐ منطق التنقل: استخدام المسار المحدد
                      final String? route = item['route'];
                      if (route != null) {
                        // إغلاق الشريط الجانبي (لشاشات الجوال)
                        if (Navigator.canPop(context)) Navigator.pop(context);
                        
                        // التنقل إلى المسار المحدد
                        // ملاحظة: إذا كان المسار هو '/dashboard/overview' (الشاشة الحالية)،
                        // فسيقوم Navigator بالبناء فوق الشاشة الحالية.
                        // إذا كنت تفضل العودة إلى المسار الأصلي دون تكرار، استخدم pushReplacementNamed
                        // لكن pushNamed أبسط في سياق هذا المثال.
                        Navigator.pushNamed(context, route);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          // زر تبديل الوضع
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ValueListenableBuilder<bool>(
              valueListenable: isDarkMode,
              builder: (context, isDark, child) {
                return ElevatedButton.icon(
                  onPressed: () {
                    isDarkMode.value = !isDarkMode.value;
                  },
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  label: Text(isDark ? 'الوضع النهاري' : 'الوضع الليلي'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 45),
                    backgroundColor: Theme.of(context).primaryColor, // اللون الأحمر
                    foregroundColor: Colors.white,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------
// 5. المحتوى الرئيسي (Main Content)
// ------------------------------------------

class _MainContent extends StatelessWidget {
  final bool isMobile;
  const _MainContent({this.isMobile = false});
  // ... (Data definitions remain the same) ...
  final List<Map<String, dynamic>> centersData = const [
    {'name': 'Center 100', 'activeTasks': 3, 'teams': {'active': 12, 'busy': 8, 'available': 15}},
    {'name': 'Center 115', 'activeTasks': 1, 'teams': {'active': 15, 'busy': 11, 'available': 13}},
  ];
  final List<Map<String, String>> activeMissions = const [
    {'id': '0555', 'type': 'حادث مروري', 'location': 'طريق المطار 102'},
    {'id': '0554', 'type': 'شك اشتباه', 'location': 'الرقة شارع دمشق'},
  ];


  @override
  Widget build(BuildContext context) {
    // ... (Build method logic remains the same) ...
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // أ. المهام النشطة والخريطة
        isMobile
            ? Column(
                children: [
                  _ActiveMissionsCard(activeMissions: activeMissions),
                  const SizedBox(height: 16),
                  _MapPlaceholder(),
                ],
              )
            : SizedBox(
                height: 300,
                child: Row(
                  children: [
                    Expanded(child: _ActiveMissionsCard(activeMissions: activeMissions)),
                    const SizedBox(width: 16),
                    Expanded(flex: 2, child: _MapPlaceholder()),
                  ],
                ),
              ),
        const SizedBox(height: 20),

        // ب. حالة المراكز
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: centersData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isMobile ? 3.0 : 2.5,
          ),
          itemBuilder: (context, index) {
            return _CenterStatusCard(center: centersData[index]);
          },
        ),
        const SizedBox(height: 20),

        // ت. إحصائيات المناوبات
        const _ShiftStatsCard(),
      ],
    );
  }
}

// ------------------------------------------
// 6. مكونات Widgets المساعدة (ActiveMissions, Map, CenterStatus, ShiftStats)
// ------------------------------------------

class _ActiveMissionsCard extends StatelessWidget {
  final List<Map<String, String>> activeMissions;
  const _ActiveMissionsCard({required this.activeMissions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        border: const Border(right: BorderSide(color: Colors.red, width: 4.0)),
        boxShadow: [BoxShadow(color: Theme.of(context).shadowColor.withOpacity(0.1), blurRadius: 5)],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('المهام النشطة', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold), textDirection: TextDirection.rtl),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: activeMissions.length,
              itemBuilder: (context, index) {
                final mission = activeMissions[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('حادث سير - #${mission['id']}', textDirection: TextDirection.rtl, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                            Text(mission['location']!, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('تفاصيل'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Theme.of(context).shadowColor.withOpacity(0.1), blurRadius: 5)],
      ),
      alignment: Alignment.center,
      child: const Text('تتبع حي للمركبات (منطقة الخريطة)'),
    );
  }
}

class _CenterStatusCard extends StatelessWidget {
  final Map<String, dynamic> center;
  const _CenterStatusCard({required this.center});

  @override
  Widget build(BuildContext context) {
    final teams = center['teams'] as Map<String, int>;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border(right: BorderSide(color: Theme.of(context).primaryColor, width: 4.0)),
        boxShadow: [BoxShadow(color: Theme.of(context).shadowColor.withOpacity(0.1), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              Text(center['name'], style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              Text('مهام نشطة: ${center['activeTasks']}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            textDirection: TextDirection.rtl,
            children: [
              _buildTeamStat(context, 'نشط', teams['active']!, Colors.red),
              _buildTeamStat(context, 'مشغول', teams['busy']!, Colors.amber),
              _buildTeamStat(context, 'متاح', teams['available']!, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamStat(BuildContext context, String label, int count, Color color) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: TextStyle(color: color.withOpacity(0.7))),
      ],
    );
  }
}

class _ShiftStatsCard extends StatefulWidget {
  const _ShiftStatsCard();

  @override
  State<_ShiftStatsCard> createState() => _ShiftStatsCardState();
}

class _ShiftStatsCardState extends State<_ShiftStatsCard> {
  String _mode = 'summary';
  String _period = 'currentMonth';
  String _searchTerm = '';

  final Map<String, dynamic> stats = const {
    'summary': {
      'currentDay': {'shifts': 10, 'missions': 20, 'responders': 15},
      'currentMonth': {'shifts': 150, 'missions': 300, 'responders': 45},
      'lastMonth': {'shifts': 145, 'missions': 280, 'responders': 43},
      'currentYear': {'shifts': 1800, 'missions': 3500, 'responders': 60},
    },
    'individual': {
      'خالد محمد': {'lastMonth': 18, 'currentMonth': 15, 'total': 210, 'currentYear': 200},
      'فاطمة أحمد': {'lastMonth': 20, 'currentMonth': 19, 'total': 240, 'currentYear': 230},
    }
  };

  @override
  Widget build(BuildContext context) {
    final currentStats = stats['summary']?[_period] ?? {};
    final searchedRescuer = stats['individual']?[_searchTerm];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border(top: BorderSide(color: Theme.of(context).primaryColor, width: 4.0)),
        boxShadow: [BoxShadow(color: Theme.of(context).shadowColor.withOpacity(0.1), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('إحصائيات المناوبات والمهمات', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.calendar_month),
                label: const Text('ملخص الفترة'),
                onPressed: () => setState(() => _mode = 'summary'),
                style: TextButton.styleFrom(
                  foregroundColor: _mode == 'summary' ? Theme.of(context).primaryColor : Colors.grey,
                  side: _mode == 'summary' ? BorderSide(color: Theme.of(context).primaryColor, width: 2) : BorderSide.none,
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('بحث عن مسعف'),
                onPressed: () => setState(() => _mode = 'individual'),
                style: TextButton.styleFrom(
                  foregroundColor: _mode == 'individual' ? Theme.of(context).primaryColor : Colors.grey,
                  side: _mode == 'individual' ? BorderSide(color: Theme.of(context).primaryColor, width: 2) : BorderSide.none,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (_mode == 'summary')
            _buildSummary(currentStats),
          if (_mode == 'individual')
            _buildIndividual(searchedRescuer),
        ],
      ),
    );
  }

  Widget _buildSummary(Map<String, dynamic> stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'اختر الفترة',
            border: OutlineInputBorder(),
            isDense: true,
          ),
          value: _period,
          items: const [
            {'value': 'currentDay', 'label': 'هذا اليوم'},
            {'value': 'currentShift', 'label': 'هذه المناوبة'},
            {'value': 'currentWeek', 'label': 'هذا الأسبوع'},
            {'value': 'currentMonth', 'label': 'هذا الشهر'},
            {'value': 'lastMonth', 'label': 'الشهر السابق'},
            {'value': 'currentYear', 'label': 'هذا العام'},
          ].map((item) => DropdownMenuItem(value: item['value'], child: Text(item['label']!))).toList(),
          onChanged: (value) => setState(() => _period = value!),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatBox(context, 'إجمالي المناوبات', stats['shifts'] ?? 0, Colors.red),
            _buildStatBox(context, 'عدد المهمات', stats['missions'] ?? 0, Colors.deepOrange),
            _buildStatBox(context, 'عدد المسعفين المناوبين', stats['responders'] ?? 0, Colors.green),
          ],
        ),
      ],
    );
  }

  Widget _buildStatBox(BuildContext context, String title, int count, Color color) {
    return Expanded(
      child: Card(
        color: color.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text('$count', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(height: 4),
              Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: color.withOpacity(0.7))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndividual(Map<String, dynamic>? rescuer) {
    return Column(
      children: [
        TextField(
          textAlign: TextAlign.right,
          decoration: const InputDecoration(
            hintText: 'ابحث باسم المسعف (مثال: خالد محمد)',
            border: OutlineInputBorder(),
            isDense: true,
            suffixIcon: Icon(Icons.search),
          ),
          onChanged: (value) => setState(() => _searchTerm = value.trim()),
        ),
        const SizedBox(height: 16),
        if (rescuer != null)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('نتائج المسعف: $_searchTerm', style: Theme.of(context).textTheme.titleMedium),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDetailStat('هذا الشهر', rescuer['currentMonth']),
                      _buildDetailStat('الشهر الماضي', rescuer['lastMonth']),
                      _buildDetailStat('هذا العام', rescuer['currentYear']),
                      _buildDetailStat('العدد الكلي', rescuer['total']),
                    ],
                  ),
                ],
              ),
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('يرجى إدخال اسم المسعف للبحث عن إحصائياته.', style: TextStyle(color: Colors.grey)),
          ),
      ],
    );
  }

  Widget _buildDetailStat(String title, int count) {
    return Column(
      children: [
        Text('$count', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

// ------------------------------------------
// 7. لوحة الفلاتر (Filter Panel)
// ------------------------------------------

class _FilterPanel extends StatefulWidget {
  const _FilterPanel();

  @override
  __FilterPanelState createState() => __FilterPanelState();
}

class __FilterPanelState extends State<_FilterPanel> {
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
          )).toList(),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              print('تطبيق الفلتر: القطاع $selectedSector، الحالة $selectedCaseCode، النوع $selectedCaseType');
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
        const SizedBox(height: 4),
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

// ------------------------------------------
// 8. شاشة مراقبة الأسطول (FleetMonitoringScreen)
// ------------------------------------------

class FleetMonitoringScreen extends StatelessWidget {
  const FleetMonitoringScreen({super.key});

  final List<Map<String, String>> activeVehicles = const [
    {'carId': 'AMB-01', 'driver': 'يوسف خالد', 'status': 'في الطريق إلى المريض', 'color': 'Red'},
    {'carId': 'AMB-05', 'driver': 'علي محمود', 'status': 'في الطريق إلى المشفى', 'color': 'Yellow'},
    {'carId': 'AMB-12', 'driver': 'فهد ناصر', 'status': 'في الطريق إلى المركز', 'color': 'Green'},
    {'carId': 'AMB-09', 'driver': 'نورة سعيد', 'status': 'متاح (استعداد)', 'color': 'Blue'},
    {'carId': 'AMB-20', 'driver': 'خالد محمد', 'status': 'غير متاح (صيانة)', 'color': 'Grey'},
  ];

  Color _getStatusColor(String status) {
    if (status.contains('المريض')) return Colors.red;
    if (status.contains('المشفى')) return Colors.amber;
    if (status.contains('المركز')) return Colors.green;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مراقبة الأسطول'),
        ),
        body: Column(
          children: [
            // منطقة الخريطة (الجزء العلوي)
            Expanded(
              flex: 1,
              child: Container(
                color: Theme.of(context).cardColor,
                alignment: Alignment.center,
                child: const Text('منطقة عرض الخريطة وتتبع المركبات'),
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
            // قائمة المركبات العاملة (الجزء السفلي)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'المركبات العاملة (${activeVehicles.length})',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: activeVehicles.length,
                itemBuilder: (context, index) {
                  final car = activeVehicles[index];
                  final statusColor = _getStatusColor(car['status']!);

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    elevation: 1,
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      leading: Icon(Icons.local_shipping, color: statusColor),
                      title: Text(
                        '${car['carId']} - ${car['driver']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'الحالة: ${car['status']}',
                        style: TextStyle(color: statusColor.withOpacity(0.8)),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          car['color']![0], // الترميز اللوني
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        print('عرض تفاصيل ${car['carId']}');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ------------------------------------------
// 9. شاشة طلبات التبديل (ShiftExchangeScreen)
// ------------------------------------------

class ShiftExchangeScreen extends StatelessWidget {
  const ShiftExchangeScreen({super.key});

  final List<Map<String, dynamic>> exchangeRequests = const [
    {'id': 1, 'sender': 'محمد بارودي', 'whith': 'محمد غصن', 'shift': 'مسائية', 'center': 140, 'status': 'Pending'},
    {'id': 2, 'sender': 'إلياس القرا','whith': 'إعتذار ',  'shift': 'صباحية', 'center': 100, 'status': 'Pending'},
    {'id': 3, 'sender': 'سارة أحمد', 'whith': 'موسى حورية', 'shift': 'ليلة', 'center': 115, 'status': 'Pending'},
    {'id': 4, 'sender': 'سارة شلبي','whith': 'محمد محسن',  'shift': 'ليلة', 'center': 115, 'status': 'Pending'},
  ];


  void _handleAccept(BuildContext context, int id, String sender) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم قبول طلب التبديل من $sender', textDirection: TextDirection.rtl)));
    print('Accepted request $id');
  }

  void _handleReject(BuildContext context, int id, String sender) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم رفض طلب التبديل من $sender', textDirection: TextDirection.rtl)));
    print('Rejected request $id');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('طلبات تبديل المناوبات'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: exchangeRequests.length,
          itemBuilder: (context, index) {
            final request = exchangeRequests[index];
            final message = 'طلب تبديل من ${request['sender']} مناوبة ${request['shift']} مركز ${request['center']}مع ${request['whith']}';

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // صندوق الرسالة
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4)],
                          ),
                          child: Text(
                            message,
                            style: const TextStyle(fontSize: 16),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // أزرار القبول والرفض
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.check, size: 18),
                              label: const Text('قبول'),
                              onPressed: () => _handleAccept(context, request['id'], request['sender']),
                              style: TextButton.styleFrom(foregroundColor: Colors.green),
                            ),
                            TextButton.icon(
                              icon: const Icon(Icons.close, size: 18),
                              label: const Text('رفض'),
                              onPressed: () => _handleReject(context, request['id'], request['sender']),
                              style: TextButton.styleFrom(foregroundColor: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ------------------------------------------
// 10. شاشة وهمية للمسارات غير المكتملة
// ------------------------------------------

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text('هذه شاشة وهمية لـ "$title". تحتاج إلى إضافة المحتوى الخاص بها.',
            style: const TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------
// 11. الدالة الرئيسية (main)
// ------------------------------------------

void main() {
  runApp(const OverviewDashboardScreen());
}