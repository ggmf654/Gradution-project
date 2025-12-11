// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// يمكنك هنا استيراد ملف الألوان الثابتة إذا كنت قد أنشأته
// import 'app_colors.dart'; 
// ====================================================================
// 1. App Theme Data Structure (هيكل بيانات الثيم)
// ====================================================================
// هيكل البيانات الذي يحدد مجموعة الألوان الكاملة لكل وضع (فاتح/داكن)
class AppThemeData {
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color primaryColor;
  final Color cardColor;
  final Color backgroundColor;
  final Color headerColor;
  final Color inputFillColor; 

  const AppThemeData({
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.primaryColor,
    required this.cardColor,
    required this.backgroundColor,
    required this.headerColor,
    required this.inputFillColor,
  });
}

// ====================================================================
// 2. App Themes Definition (تعريف الثيمات)
// ====================================================================

class AppThemes {
  // 1. تعريف الوضع الفاتح (Light Theme)
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.red,
    primaryColor: Colors.red[700],
    cardColor: Colors.white, // لون البطاقات في الوضع الفاتح
    scaffoldBackgroundColor: Colors.grey[100],
    
    // تحديث AppBar ليظهر بشكل جيد في الوضع الفاتح
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      centerTitle: true,
    ),
    
    // تخصيص ألوان الإدخال (TextFields) لتعمل جيداً في الوضع الفاتح
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      filled: true,
      fillColor: Colors.white,
      labelStyle: TextStyle(color: Colors.grey[700]),
    ),
    
    // تخصيص لون عناصر الراديو والمفاتيح
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.red[700];
          }
          return Colors.grey;
        },
      ),
    ),
  );

  // 2. تعريف الوضع الداكن (Dark Theme)
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.red,
    primaryColor: Colors.red[600],
    cardColor: Colors.grey[850], // لون البطاقات في الوضع الداكن
    scaffoldBackgroundColor: Colors.grey[900],
    
    // تحديث AppBar ليظهر بشكل جيد في الوضع الداكن
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    
    // تخصيص ألوان الإدخال (TextFields) لتعمل جيداً في الوضع الداكن
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      filled: true,
      fillColor: Colors.grey[800],
      labelStyle: const TextStyle(color: Colors.white70),
      hintStyle: const TextStyle(color: Colors.white54),
    ),
    
    // تخصيص لون عناصر الراديو والمفاتيح
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.red[600];
          }
          return Colors.grey[600];
        },
      ),
    ),
  );
}
