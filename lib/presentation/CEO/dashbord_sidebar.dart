import 'package:flutter/material.dart';

class DashboardSidebar extends StatelessWidget {
  const DashboardSidebar();

  @override
  Widget build(BuildContext context) {
    // قائمة العناصر بالمسارات المحددة
    final List<Map<String, dynamic>> navItems = [
      {'name': 'نظرة عامة (Overview)', 'icon': Icons.home, 'active': true, 'route': '/overview'},
      {'name': 'قائمة البلاغات', 'icon': Icons.list_alt, 'active': false, 'route': '/reports'},
      {'name': 'مراقبة الأسطول', 'icon': Icons.pin_drop, 'active': false, 'route': '/fleet'},
      {'name': 'إدارة المناوبات', 'icon': Icons.schedule, 'active': false, 'route': '/shifts'},
      {'name': 'توزيع الجدول', 'icon': Icons.table_chart, 'active': false, 'route': '/schedule'},
      {'name': 'طلبات التبديل', 'icon': Icons.notifications, 'active': false, 'route': '/exchange', 'notificationCount': 3},
      {'name': 'الإعدادات', 'icon': Icons.settings, 'active': false, 'route': '/settings'},
    ];

    return Drawer(
      elevation: 5,
      child: Column(
        children: [
          DrawerHeader(
            child: Text('EORMS', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 28, fontWeight: FontWeight.bold)),
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

        ],
      ),
    );
  }
}