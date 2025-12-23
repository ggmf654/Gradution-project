import 'package:flutter/material.dart';

class WelcomeButtonModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const WelcomeButtonModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
}
