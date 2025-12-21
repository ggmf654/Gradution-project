// app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Method to get colors based on current theme
  static Color getPrimaryText(BuildContext context) {
    return isDarkMode(context) ? darkPrimaryText : lightPrimaryText;
  }

  static Color getSecondaryText(BuildContext context) {
    return isDarkMode(context) ? darkSecondaryText : lightSecondaryText;
  }

  static Color getInputFill(BuildContext context) {
    return isDarkMode(context) ? darkInputFill : lightInputFill;
  }

  static Color getBackground(BuildContext context) {
    return isDarkMode(context) ? darkBackground : lightBackground;
  }

  static Color getCard(BuildContext context) {
    return isDarkMode(context) ? darkCard : lightCard;
  }

  static Color getScaffold(BuildContext context) {
    return isDarkMode(context) ? darkScaffold : lightScaffold;
  }

  static Color getDivider(BuildContext context) {
    return isDarkMode(context) ? darkDivider : lightDivider;
  }

  static Color getBorder(BuildContext context) {
    return isDarkMode(context) ? darkBorder : lightBorder;
  }

  // Helper method to check dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // Primary Colors (theme-independent)
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color primaryBlueDark = Color(0xFF1565C0);
  static const Color primaryBlueLight = Color(0xFF42A5F5);

  // Status Colors (theme-independent)
  static const Color statusRed = Color(0xFFE53935);
  static const Color statusYellow = Color(0xFFFFB300);
  static const Color statusGreen = Color(0xFF43A047);
  static const Color statusGrey = Color(0xFF757575);

  // Light Theme Colors
  static const Color lightPrimaryText = Color(0xFF212121);
  static const Color lightSecondaryText = Color(0xFF757575);
  static const Color lightInputFill = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightScaffold = Color(0xFFF5F5F5);
  static const Color lightDivider = Color(0xFFE0E0E0);
  static const Color lightBorder = Color(0xFFBDBDBD);

  // Dark Theme Colors
  static const Color darkPrimaryText = Color(0xFFFFFFFF);
  static const Color darkSecondaryText = Color(0xFFB0BEC5);
  static const Color darkInputFill = Color(0xFF424242);
  static const Color darkBackground = Color(0xFF303030);
  static const Color darkCard = Color(0xFF424242);
  static const Color darkScaffold = Color(0xFF303030);
  static const Color darkDivider = Color(0xFF616161);
  static const Color darkBorder = Color(0xFF757575);

  // Common Colors (theme-independent)
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Button Colors (theme-independent)
  static const Color buttonPrimary = Color(0xFF1976D2);
  static const Color buttonSecondary = Color(0xFF757575);
  static const Color buttonSuccess = Color(0xFF4CAF50);
  static const Color buttonWarning = Color(0xFFFF9800);
  static const Color buttonError = Color(0xFFF44336);
}
extension AppColorsExtension on BuildContext {
  // Theme mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // Text colors
  Color get primaryTextColor => AppColors.getPrimaryText(this);
  Color get secondaryTextColor => AppColors.getSecondaryText(this);

  // Background colors
  Color get backgroundColor => AppColors.getBackground(this);
  Color get scaffoldColor => AppColors.getScaffold(this);
  Color get cardColor => AppColors.getCard(this);

  // UI colors
  Color get inputFillColor => AppColors.getInputFill(this);
  Color get dividerColor => AppColors.getDivider(this);
  Color get borderColor => AppColors.getBorder(this);

  // Constant colors (theme-independent)
  Color get primaryBlue => AppColors.primaryBlue;
  Color get statusRed => AppColors.statusRed;
  Color get statusYellow => AppColors.statusYellow;
  Color get statusGreen => AppColors.statusGreen;
  Color get success => AppColors.success;
  Color get error => AppColors.error;
  Color get warning => AppColors.warning;
}