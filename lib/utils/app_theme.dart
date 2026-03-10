import 'package:flutter/material.dart';
import 'package:islami_app/utils/app_colors.dart';

class AppTheme {
  static ThemeData darktheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.transparentColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor, // ضيف اللون هنا
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      selectedLabelStyle: TextStyle(color: Colors.white),
      showUnselectedLabels: false,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blackBgColor,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
    ),
  );
}
