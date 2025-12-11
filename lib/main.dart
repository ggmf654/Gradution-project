// ignore_for_file: camel_case_types

import 'package:ems_op_room/core/app_themes.dart'; // <== NEW: تم استيراد ملف الثيمات
import 'package:ems_op_room/pages/presenation/Reports/Reports.dart';
import 'package:ems_op_room/pages/presenation/lidar/lidar.dart';
import 'package:ems_op_room/pages/presenation/radio/radio&car.dart';
import 'package:ems_op_room/pages/presenation/seting/seting.dart';
import 'package:ems_op_room/pages/presenation/splash%20view/splash_view_body.dart';
import 'package:ems_op_room/pages/presenation/login/login.dart';
import 'package:ems_op_room/pages/presenation/welcome/welcome.dart';
import 'package:ems_op_room/pages/presenation/CEO/CEO.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const EMS_OP_ROOM());
}

class EMS_OP_ROOM extends StatefulWidget {
  const EMS_OP_ROOM({super.key});

  @override
  State<EMS_OP_ROOM> createState() => _EMS_OP_ROOMState();
}

class _EMS_OP_ROOMState extends State<EMS_OP_ROOM> {
  // 1. تعريف حالة وضع العرض الافتراضية
  ThemeMode _themeMode = ThemeMode.dark; // البدء بالوضع الداكن كافتراضي

  // 2. دالة التبديل التي سيتم تمريرها لصفحة الإعدادات
  void _changeTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      // 3. تطبيق وضع العرض المُختار على MaterialApp
      themeMode: _themeMode,

      // 4. استدعاء الوضع الفاتح من الملف المركزي AppThemes
      theme: AppThemes.lightTheme, 

      // 5. استدعاء الوضع الداكن من الملف المركزي AppThemes
      darkTheme: AppThemes.darkTheme,
      
      home: const SplashViewBody(),
      routes: {
        '/login': (context) => const Login(),
        '/welcome': (context) => const Welcome(),
        // تم تغيير اسم الكلاس هنا إلى Radiocar
        '/radiocar': (context) => const Radiocar(), 
        '/lidar': (context) => const Lidar(),
        // تم تغيير المسار ليناسب الكلاس الموجود في الإمبورتس
        '/cinter': (context) => const Center(), 
        '/reports': (context) => const Reports(),
        // 6. تمرير الدالة (callback) لصفحة الإعدادات
        '/seting': (context) => SettingPage(
              currentMode: _themeMode,
              onModeChanged: _changeTheme,
            ),
            '/Dashboard': (context)=> const OverviewDashboardScreen(),
      
      },
    );
  }
}
