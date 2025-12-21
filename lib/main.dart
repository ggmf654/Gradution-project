import '/presentation/CEO/CEO.dart';
import 'core/app_themes.dart';
import 'presentation/CEO/fleet_monitoring_screen.dart';
import 'presentation/CEO/placeholder_screen.dart';
import 'presentation/CEO/shift_exchange_screen.dart';
import 'presentation/splash%20view/splash_view_body.dart';
import 'package:flutter/material.dart';
import 'presentation/seting/setting.dart';
import 'presentation/login/login.dart';
import 'presentation/welcome/welcome.dart';
import 'presentation/Reports/reports.dart';
import 'presentation/radio/radio&car.dart';
import 'presentation/lidar/lidar.dart';
import 'presentation/center/center.dart';
import 'presentation/CEO/dashbord_body.dart';

void main() {
  runApp(const EMS_OP_ROOM());
}

final ValueNotifier<bool> isDarkMode = ValueNotifier(false);

class EMS_OP_ROOM extends StatelessWidget {
  const EMS_OP_ROOM({super.key});

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
            '/splash': (context) => const SplashViewBody(),
            '/login': (context) => const Login(),
            '/welcome': (context) => const Welcome(),
            '/dashboard': (context) => const OverviewDashboardScreen(),
            '/radiocar': (context) => const RadioCar(),
            '/lidar': (context) => const Lidar(),
            '/center': (context) => const CenterPage(),
            '/reports': (context) => const Reports(),
            '/settings': (context) => const SettingPage(),
            '/exchange': (context) => const ShiftExchangeScreen(),
            '/overview': (context) => const DashboardBody(),
            '/fleet': (context) => const FleetMonitoringScreen(),
            '/shifts': (context) => const PlaceholderScreen(title: 'إدارة المناوبات'),
            '/schedule': (context) => const PlaceholderScreen(title: 'توزيع الجدول'),
          },
          home:  MissionTheme(
            theme: Theme.of(context).brightness == Brightness.dark
                ? AppThemeData.dark
                : AppThemeData.light,
            child: SplashViewBody(),
          ),
        );
      },
    );
  }
}
