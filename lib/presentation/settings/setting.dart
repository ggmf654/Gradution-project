import 'package:flutter/material.dart';
import '../../../main.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات', style: TextStyle(color: theme.textTheme.bodyLarge!.color)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                        color: isDarkMode.value ? Colors.amber.shade700 : Colors.blueGrey),
                    const SizedBox(width: 15),
                    const Text('الوضع الداكن (Dark Mode)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
                Switch(
                  value: isDarkMode.value,
                  onChanged: (value) {
                    isDarkMode.value = value;
                  },
                  activeThumbColor: theme.primaryColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: const Text('إعدادات الإشعارات'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: theme.hintColor),
          ),
          ListTile(
            title: const Text('تسجيل الخروج'),
            trailing: Icon(Icons.exit_to_app, size: 16, color: theme.primaryColor),
            onTap: () {
              // Logout logic
            },
          ),
        ],
      ),
    );
  }
}
