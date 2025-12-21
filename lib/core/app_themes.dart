import 'package:flutter/material.dart';
import 'app_colors.dart';

class MissionTheme extends InheritedWidget {
  final AppThemeData theme;

  const MissionTheme({
    super.key,
    required this.theme,
    required super.child,
  });

  static AppThemeData of(BuildContext context) {
    final missionTheme = context.dependOnInheritedWidgetOfExactType<MissionTheme>();
    if (missionTheme == null) {
      // Fallback to light theme if MissionTheme is not found
      return AppThemeData.light;
    }
    return missionTheme.theme;
  }

  @override
  bool updateShouldNotify(covariant MissionTheme oldWidget) {
    return oldWidget.theme != theme;
  }
}

class AppThemeData {
  final ThemeData materialTheme;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color inputFillColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color scaffoldBackgroundColor;
  final Color dividerColor;
  final Color borderColor;
  final Color primaryColor;
  final Color appBarBackground;
  final Color appBarForeground;

  const AppThemeData({
    required this.materialTheme,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.inputFillColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.scaffoldBackgroundColor,
    required this.dividerColor,
    required this.borderColor,
    required this.primaryColor,
    required this.appBarBackground,
    required this.appBarForeground,
  });

  // Light Theme
  static final AppThemeData light = AppThemeData(
    materialTheme: AppThemes.lightTheme,
    primaryTextColor: AppColors.lightPrimaryText,
    secondaryTextColor: AppColors.lightSecondaryText,
    inputFillColor: AppColors.lightInputFill,
    backgroundColor: AppColors.lightBackground,
    cardColor: AppColors.lightCard,
    scaffoldBackgroundColor: AppColors.lightScaffold,
    dividerColor: AppColors.lightDivider,
    borderColor: AppColors.lightBorder,
    primaryColor: AppColors.primaryBlue,
    appBarBackground: AppColors.white,
    appBarForeground: AppColors.lightPrimaryText,
  );

  // Dark Theme
  static final AppThemeData dark = AppThemeData(
    materialTheme: AppThemes.darkTheme,
    primaryTextColor: AppColors.darkPrimaryText,
    secondaryTextColor: AppColors.darkSecondaryText,
    inputFillColor: AppColors.darkInputFill,
    backgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkCard,
    scaffoldBackgroundColor: AppColors.darkScaffold,
    dividerColor: AppColors.darkDivider,
    borderColor: AppColors.darkBorder,
    primaryColor: AppColors.primaryBlueLight,
    appBarBackground: AppColors.darkCard,
    appBarForeground: AppColors.darkPrimaryText,
  );
}

// AppThemes class for Material ThemeData configurations
class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.lightScaffold,
    cardColor: AppColors.lightCard,
    dividerColor: AppColors.lightDivider,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.lightPrimaryText,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.lightPrimaryText),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.lightBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.lightBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      filled: true,
      fillColor: AppColors.lightInputFill,
      labelStyle: TextStyle(color: AppColors.lightSecondaryText),
      hintStyle: TextStyle(color: AppColors.lightSecondaryText.withOpacity(0.7)),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightPrimaryText),
      bodyMedium: TextStyle(color: AppColors.lightPrimaryText),
      bodySmall: TextStyle(color: AppColors.lightSecondaryText),
      titleLarge: TextStyle(
        color: AppColors.lightPrimaryText,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.primaryBlueLight,
      background: AppColors.lightBackground,
      surface: AppColors.lightCard,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    primaryColor: AppColors.primaryBlueLight,
    scaffoldBackgroundColor: AppColors.darkScaffold,
    cardColor: AppColors.darkCard,
    dividerColor: AppColors.darkDivider,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkCard,
      foregroundColor: AppColors.darkPrimaryText,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.darkPrimaryText),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryBlueLight, width: 2),
      ),
      filled: true,
      fillColor: AppColors.darkInputFill,
      labelStyle: TextStyle(color: AppColors.darkSecondaryText),
      hintStyle: TextStyle(color: AppColors.darkSecondaryText.withOpacity(0.7)),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkPrimaryText),
      bodyMedium: TextStyle(color: AppColors.darkPrimaryText),
      bodySmall: TextStyle(color: AppColors.darkSecondaryText),
      titleLarge: TextStyle(
        color: AppColors.darkPrimaryText,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryBlueLight,
      secondary: AppColors.primaryBlue,
      background: AppColors.darkBackground,
      surface: AppColors.darkCard,
    ),
  );
}

// Extension for easy access
extension ThemeContextExtension on BuildContext {
  AppThemeData get missionTheme => MissionTheme.of(this);
  Color get primaryTextColor => MissionTheme.of(this).primaryTextColor;
  Color get secondaryTextColor => MissionTheme.of(this).secondaryTextColor;
  Color get inputFillColor => MissionTheme.of(this).inputFillColor;
  Color get backgroundColor => MissionTheme.of(this).backgroundColor;
  Color get cardColor => MissionTheme.of(this).cardColor;
  ThemeData get materialTheme => MissionTheme.of(this).materialTheme;
}