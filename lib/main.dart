// ignore_for_file: camel_case_types

import 'package:ems_op_room/pages/presenation/Reports/Reports.dart';
import 'package:ems_op_room/pages/presenation/lidar/lidar.dart';
import 'package:ems_op_room/pages/presenation/radio/radio&car.dart';
import 'package:ems_op_room/pages/presenation/seting/seting.dart';
import 'package:ems_op_room/pages/presenation/splash%20view/splash_view_body.dart';
import 'package:ems_op_room/pages/presenation/login/login.dart';
import 'package:ems_op_room/pages/presenation/welcome/welcome.dart';

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

      // 4. تعريف الوضع الفاتح (Light Theme)
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        primaryColor: Colors.red[700],
        cardColor: Colors.white, // لون البطاقات في الوضع الفاتح
        scaffoldBackgroundColor: Colors.grey[100],
        // تحديث AppBar ليظهر بشكل جيد في الوضع الفاتح
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
      ),

      // 5. تعريف الوضع الداكن (Dark Theme)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        primaryColor: Colors.red[600],
        cardColor: Colors.grey[850], // لون البطاقات في الوضع الداكن
        scaffoldBackgroundColor: Colors.grey[900],
        // تحديث AppBar ليظهر بشكل جيد في الوضع الداكن
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
        ),
      ),
      
      home: const SplashViewBody(),
      routes: {
        '/login': (context) => const Login(),
        '/welcome': (context) => const Welcome(),
        '/radiocar': (context) => const Radiocar(),
        '/lidar': (context) => const Lidar(),
        // ملاحظة: Center() هنا قد يتعارض مع Widget الأساسي لـ Flutter (Center)
        // لذا يُفضل تغيير اسم الكلاس Center() في مسارك الأصلي
        '/cinter': (context) => const Center(), 
        '/reports': (context) => const Reports(),
        // 6. تمرير الدالة (callback) لصفحة الإعدادات
        '/seting': (context) => SettingPage(
              currentMode: _themeMode,
              onModeChanged: _changeTheme,
            ),
      },
    );
  }
}