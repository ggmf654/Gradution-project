import 'package:flutter/material.dart';

// تعريف الدالة المساعدة لتمثيل تطبيقك، والتي يجب أن تكون في main.dart
// ولأغراض العرض هنا، سنفترض وجود دالة callback لتغيير الوضع
typedef ThemeModeCallback = void Function(ThemeMode mode);

// هذا هو المكون الأساسي لصفحة الإعدادات
class SettingPage extends StatelessWidget {
  final ThemeMode currentMode;
  final ThemeModeCallback onModeChanged;

  const SettingPage({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  // الألوان المستخدمة في التصميم (تماشياً مع تصميم Lidar)
  static const Color _bgColorDark = Color(0xFF1E1E1E);
  static const Color _cardColorDark = Color(0xFF2B2B2B);
  static const Color _lightGrey = Colors.white70;

  @override
  Widget build(BuildContext context) {
    // تحديد الألوان بناءً على الوضع الحالي
    final isDarkMode = currentMode == ThemeMode.dark;
    final backgroundColor = isDarkMode ? _bgColorDark : Colors.white;
    final cardColor = isDarkMode ? _cardColorDark : const Color(0xFFF0F0F0);
    final primaryTextColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'الإعدادات',
          style: TextStyle(color: primaryTextColor),
        ),
        backgroundColor: cardColor,
        iconTheme: IconThemeData(color: primaryTextColor),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // بطاقة خيار الوضع المظلم/الفاتح
            Card(
              color: cardColor,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: isDarkMode ? _lightGrey : Colors.blueGrey,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'وضع العرض',
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    // زر التبديل الفعلي
                    Switch(
                      value: isDarkMode,
                      onChanged: (bool value) {
                        onModeChanged(value ? ThemeMode.dark : ThemeMode.light);
                      },
                      activeColor: Colors.blueAccent,
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                    Text(
                      isDarkMode ? 'مظلم' : 'فاتح',
                      style: TextStyle(
                        color: primaryTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // يمكن إضافة المزيد من الإعدادات هنا لاحقاً
          ],
        ),
      ),
    );
  }
}