import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemUiOverlayStyle
import '/consts/app_colors.dart';

class Styles {
  //

  static ThemeData themeData({
    required bool isDarkTheme,
    required BuildContext context,
  }) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: isDarkTheme
          ? AppColors.darkScaffoldColor
          : AppColors.lightScaffoldColor,
      cardColor: isDarkTheme
          ? const Color.fromARGB(255, 13, 6, 37)
          : AppColors.lightCardColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// static void setSystemUIOverlayStyle({required bool isDarkTheme}) {
//   // Set the status bar color and icons based on the theme
//   final statusBarColor = isDarkTheme
//       ? Colors.black // You can customize this color as needed
//       : Colors.white; // You can customize this color as needed

//   // Set the SystemUiOverlayStyle
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: statusBarColor,
//     statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
//   ));
// }
