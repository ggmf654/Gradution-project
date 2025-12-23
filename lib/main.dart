import 'package:ems_op_room/presentation/reports/reports_page.dart';
import 'package:flutter/material.dart';
import 'core/app_themes.dart';
import 'presentation/CEO/CEO.dart';
import 'presentation/login/login.dart';
import 'presentation/splash view/splash_page_body.dart';
import 'presentation/welcome/welcome.dart';
import 'presentation/radio/radio&car.dart';
import 'presentation/lidar/lidar.dart';
import 'presentation/center/center.dart';
import 'presentation/settings/setting.dart';
import 'presentation/CEO/components/dashbord_body.dart';
import 'presentation/CEO/components/fleet_monitoring_screen.dart';
import 'presentation/CEO/components/shift_exchange_screen.dart';
import 'presentation/CEO/components/placeholder_screen.dart';

void main() {
  runApp(const EMSOpRoom());
}

final ValueNotifier<bool> isDarkMode = ValueNotifier(false);

class EMSOpRoom extends StatelessWidget {
  const EMSOpRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, darkMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,

          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.red,
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.red,
          ),

          initialRoute: '/splash',

          routes: {
            '/splash': (context) => MissionTheme(
              theme: Theme.of(context).brightness == Brightness.dark
                  ? AppThemeData.dark
                  : AppThemeData.light,
              child: const SplashViewBody(),
            ),

            '/login': (context) => const LoginPage(),
            '/welcome': (context) => const WelcomePage(),
            '/dashboard': (context) => const OverviewDashboardScreen(),
            '/radiocar': (context) => const RadioCarPage(),
            '/lidar': (context) => const Lidar(),
            '/center': (context) => const CenterPage(),
            '/reports': (context) => const ReportsPage(),
            '/settings': (context) => const SettingPage(),
            '/exchange': (context) => const ShiftExchangePage(),
            '/overview': (context) => const DashboardBody(),
            '/fleet': (context) => const FleetMonitoringPage(),
            '/shifts': (context) =>
            const PlaceholderScreen(title: 'إدارة المناوبات'),
            '/schedule': (context) =>
            const PlaceholderScreen(title: 'توزيع الجدول'),
          },
        );
      },
    );
  }
}
