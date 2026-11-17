import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryDark = Color(0xFF5A4AD1);
  static const Color primaryLight = Color(0xFFF0EEFE);
  static const Color primaryLightHover = Color(0xFFE4E0FE);

  // Gradient colors
  static const Color gradientStart = Color(0xFF7D6CF0);
  static const Color gradientEnd = Color(0xFF5B48E5);

  // Background colors
  static const Color background = Color(0xFFF8F9FE);
  static const Color cardBackground = Colors.white;

  // Text colors
  static const Color textDark = Color(0xFF1E1B4B);
  static const Color textMedium = Color(0xFF4B5563);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color textLight = Colors.white;

  // Border & Divider colors
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFECFDF5);
  static const Color tagBackground = Color(0xFFEEECFE);
}
