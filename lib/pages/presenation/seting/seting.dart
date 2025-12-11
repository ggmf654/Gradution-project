// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// تعريف الدالة المساعدة (Callback) لتمريرها من main.dart
typedef ThemeModeCallback = void Function(ThemeMode mode);

// هذا هو المكون الأساسي لصفحة الإعدادات
class SettingPage extends StatelessWidget {
  // 1. استقبال وضع الثيم الحالي (Light/Dark)
  final ThemeMode currentMode;
  // 2. استقبال دالة التبديل (Callback Function)
  final ThemeModeCallback onModeChanged;

  const SettingPage({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    // تحديد ما إذا كان الوضع الداكن مُفعّلاً حاليًا
    final bool isDarkMode = currentMode == ThemeMode.dark;

    // استخدام الألوان من الثيم المطبق حاليًا (من MaterialApp في main.dart)
    final theme = Theme.of(context);
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final Color secondaryTextColor = theme.hintColor;
    // استخدام لون خلفية الشاشة (Scaffold Background) ولون البطاقة (Card Color) المحدد في الثيم
    final Color cardColor = theme.cardColor;
    final Color primaryColor = theme.primaryColor;

    return Scaffold(
      // Scaffold سيستخدم اللون scaffoldBackgroundColor المعرف في main.dart
      appBar: AppBar(
        title: Text(
          'الإعدادات',
          style: TextStyle(color: primaryTextColor),
        ),
        // AppBar سيستخدم AppBarTheme المعرفة في main.dart
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // =================================================================
          // عنصر تبديل الوضع الداكن
          // =================================================================
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              // يستخدم لون البطاقة الخاص بالثيم الحالي (cardColor)
              color: cardColor, 
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.05),
                  blurRadius: 5,
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      // لون الأيقونة: أصفر للداكن، أزرق رمادي للفاتح
                      color: isDarkMode ? Colors.amber.shade700 : Colors.blueGrey,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'الوضع الداكن (Dark Mode)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryTextColor,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: isDarkMode,
                  // عند تغيير زر التبديل
                  onChanged: (bool value) {
                    // استدعاء الدالة الممررة (Callback) لتحديث الحالة في main.dart
                    onModeChanged(value ? ThemeMode.dark : ThemeMode.light);
                  },
                  activeColor: primaryColor, // يستخدم لون التطبيق الأساسي
                  inactiveTrackColor: Colors.grey.shade300,
                ),
              ],
            ),
          ),
          // =================================================================
          
          const SizedBox(height: 10),

          // يمكنك إضافة المزيد من الإعدادات هنا
          ListTile(
            // ListTile سيستخدم اللون primaryTextColor
            title: Text('إعدادات الإشعارات', style: TextStyle(color: primaryTextColor)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: secondaryTextColor),
          ),
          ListTile(
            title: Text('تسجيل الخروج', style: TextStyle(color: primaryTextColor)),
            trailing: Icon(Icons.exit_to_app, size: 16, color: primaryColor),
            onTap: () {
              // منطق تسجيل الخروج
            },
          ),
        ],
      ),
    );
  }
}
