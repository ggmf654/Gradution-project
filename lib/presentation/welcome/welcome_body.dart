// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width to make the layout responsive
    final double screenWidth = MediaQuery.of(context).size.width;

    // Define the number of columns based on screen width
    // This makes the layout flexible, showing more columns on larger screens
    // and fewer columns (or more rows) on smaller screens.
    int crossAxisCount;
    if (screenWidth > 1200) {
      crossAxisCount = 5; // For very large screens
    } else if (screenWidth > 800) {
      crossAxisCount = 3; // For larger screens (desktop/tablet landscape)
    } else if (screenWidth > 500) {
      crossAxisCount = 2; // For medium screens (tablet portrait)
    } else {
      crossAxisCount = 1; // For small screens (mobile)
    }

    // تعريف بيانات الأزرار الستة
    List<Map<String, dynamic>> buttonsData = [
      {
        'title': 'lidar',
        'subtitle': 'Manage and organize op room',
        'icon': Icons.leaderboard, // Example icon
        'onTap': () {
          Navigator.pushNamed(context, "/lidar");
          print('Station button pressed');
        },
      },
      {
        'title': 'Reports',
        'subtitle': 'Submit and manage reports',
        'icon': Icons.assignment, // Example icon
        'onTap': () {
          Navigator.pushNamed(context, "/reports");
          print('Reports button pressed');
        },
      },
      {
        'title': 'radio',
        'subtitle': 'Manage sectors and radio message',
        'icon': Icons.radio, // Example icon
        'onTap': () {
          Navigator.pushNamed(context, "/radiocar");
          print('Sectors button pressed');
        },
      },
      {
        'title': 'Center',
        'subtitle': 'Manage main center',
        'icon': Icons.house_sharp, // Example icon
        'onTap': () {
          Navigator.pushNamed(context, "/center");
          print('Center button pressed');
        },
      },
      {
        'title': 'Settings',
        'subtitle': 'Customize system settings',
        'icon': Icons.settings, // Example icon
        'onTap': () {
          // تم تعديل المسار هنا لتصحيحه إذا كان المقصود هو /settings
          Navigator.pushNamed(context, "/settings");
          print('Settings button pressed');
        },
      },
      // ⭐ إضافة الزر الجديد: Dashboard
      {
        'title': 'Dashboard',
        'subtitle': 'View system overview and statistics',
        'icon': Icons.dashboard, // آيقونة مناسبة
        'onTap': () {
          // المسار المطلوب للانتقال إلى صفحة لوحة القيادة
          Navigator.pushNamed(context, "/dashboard");
          print('Dashboard button pressed');
        },
      },
    ];

    // ⭐ تحديد عدد العناصر ليكون مساوياً لعدد الأزرار في القائمة
    final int buttonCount = buttonsData.length; // سيكون 6 الآن
    final theme = Theme.of(context);
    final primaryTextColor =
        theme.textTheme.bodyLarge?.color ?? Colors.black;
    final secondaryTextColor = theme.textTheme.bodySmall?.color?.withOpacity(0.7) ??
        Colors.grey;

    return Container(
      // Optional: Add padding around the entire content
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Header section
          // (المحتوى الخاص بالهيدر محذوف في الكود الأصلي، يمكنك إضافته هنا)

          // Spacer below the header
          const SizedBox(height: 40), // Spacer below the welcome text

          // Flexible Grid of Buttons
          Expanded( // Allows the GridView to take available space
            child: GridView.builder(
              shrinkWrap: true, // Prevents unlimited height error
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling in grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount, // Dynamic number of columns
                crossAxisSpacing: 20.0, // Spacing between columns
                mainAxisSpacing: 20.0, // Spacing between rows
                childAspectRatio: 1.2, // Adjust aspect ratio for better button sizing
              ),
              // ⭐ التغيير هنا: استخدام buttonCount بدلاً من الرقم الثابت 5
              itemCount: buttonCount, // عدد الأزرار الآن 6
              itemBuilder: (BuildContext context, int index) {
                // التأكد من أن buttonCount يعكس حجم buttonsData
                final button = buttonsData[index];

                return GestureDetector(
                  onTap: button['onTap'],
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            button['icon'],
                            size: 40,
                            color: Colors.red[600], // Icon color
                          ),
                          const SizedBox(height: 10),
                          Text(
                            button['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            button['subtitle'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
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