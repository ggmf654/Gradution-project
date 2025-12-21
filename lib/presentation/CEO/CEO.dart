// ----------------------------------------------------
// ملف Flutter متكامل: لوحة التحكم مع التنقل بالمسارات
// ----------------------------------------------------

// ignore_for_file: deprecated_member_use, unnecessary_to_list_in_spreads, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';

import 'dashbord_body.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<bool>(
        valueListenable: isDarkMode,
        builder: (context, isDark, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: const DashboardBody(),
          );
        },
      ),
    );
  }
}
