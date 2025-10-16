import 'package:flutter/material.dart';

// شاشة Lidar مصممة لتكون متوافقة مع الوضع الفاتح والداكن
class Lidar extends StatelessWidget {
  const Lidar({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام Theme.of(context) لضمان التجاوب مع وضع العرض الحالي (Dark/Light)
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final primaryTextColor = isDarkMode ? Colors.white : Colors.black87;
    final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.grey[600];
    final primaryColor = theme.primaryColor;
    final cardColor = theme.cardColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'غرفة عمليات Lidar',
          style: TextStyle(color: primaryTextColor),
        ),
        iconTheme: IconThemeData(color: primaryTextColor),
        // لون شريط التطبيق سيتغير بناءً على الـ darkTheme/theme في main.dart
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة حالة النظام
            _buildStatusCard(
              cardColor,
              primaryTextColor,
              secondaryTextColor,
              primaryColor,
              'حالة النظام',
              'جميع الأنظمة تعمل بكفاءة عالية',
              Icons.check_circle_outline,
              Colors.green,
            ),
            const SizedBox(height: 20),

            // شبكة لوحات القيادة (Grid of Widgets)
            GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildDataCard(cardColor, primaryTextColor, secondaryTextColor, 'بيانات الحساسات', '345 نقطة/ثانية', Icons.radar),
                _buildDataCard(cardColor, primaryTextColor, secondaryTextColor, 'نطاق التغطية', '5.2 كم مربع', Icons.location_on),
                _buildDataCard(cardColor, primaryTextColor, secondaryTextColor, 'استهلاك الطاقة', '78%', Icons.battery_full),
                _buildDataCard(cardColor, primaryTextColor, secondaryTextColor, 'درجة الحرارة', '28°C', Icons.thermostat),
              ],
            ),
            const SizedBox(height: 20),

            // قسم إعدادات التشغيل السريع
            Text(
              'إعدادات التشغيل السريع',
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            // زر للوضع الليلي
            ListTile(
              tileColor: cardColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              leading: Icon(Icons.flash_on, color: primaryColor),
              title: Text('تفعيل وضع المسح الليلي', style: TextStyle(color: primaryTextColor)),
              trailing: Switch(
                value: true, // مثال على قيمة مفتاح
                onChanged: (bool value) {
                  // قم بتنفيذ منطق التحكم هنا
                  print('Night scan mode changed to $value');
                },
                activeColor: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            // زر لإعادة تشغيل النظام
            ElevatedButton.icon(
              onPressed: () {
                print('System restart initiated');
              },
              icon: const Icon(Icons.restart_alt),
              label: const Text('إعادة تشغيل نظام Lidar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // تم نقل دوال المساعدة إلى داخل الكلاس (Lidar) لحل مشكلة النطاق (Scope)

  Widget _buildStatusCard(
    Color cardColor,
    Color primaryTextColor,
    Color secondaryTextColor,
    Color primaryColor,
    String title,
    String subtitle,
    IconData icon,
    Color statusColor,
  ) {
    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: statusColor, width: 2), // إطار لوني للحالة
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icon, size: 36, color: statusColor),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: secondaryTextColor),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(
    Color cardColor,
    Color primaryTextColor,
    Color secondaryTextColor,
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: secondaryTextColor),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
