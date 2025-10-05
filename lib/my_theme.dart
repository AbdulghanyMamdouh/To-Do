import 'package:flutter/material.dart';

class MyTheme {
  //light mode colors
  static Color primaryColor = const Color(0xff5D9CEC);
  static Color greenColor = const Color(0xff61E757);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color backgrondLightColor = const Color(0xffDFECDB);
  static Color redColor = const Color(0xffEC4B4B);
  static Color blackColor = const Color(0xff383838);
  static Color grayColor = const Color(0xffA9A9A9);
  //dark mode colors
  static Color backgrondDarkColor = const Color(0xff060E1E);
  static Color blackDarkColor = const Color(0xff141922);

  static ThemeData lightMode = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgrondLightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: grayColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        iconSize: 40,
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        shape: StadiumBorder(
          side: BorderSide(
            color: whiteColor,
            width: 4,
          ),
        )),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: whiteColor,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: blackColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: blackColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
  static ThemeData darkMode = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgrondDarkColor,
    appBarTheme: AppBarTheme(
      //color: Colors.transparent,
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: whiteColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        iconSize: 40,
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        shape: StadiumBorder(
          side: BorderSide(
            color: blackDarkColor,
            width: 4,
          ),
        )),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        side: BorderSide(
          color: primaryColor,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: whiteColor,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: blackColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: blackColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
