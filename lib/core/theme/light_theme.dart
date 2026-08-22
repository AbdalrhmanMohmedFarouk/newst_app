import 'package:flutter/material.dart';
import 'package:newst_app/core/theme/light_color.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
  ),
  scaffoldBackgroundColor: Color(0XFFf5f5f5),
  primaryColor: LightColors.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.white
    ),
  ////   titleTextStyle: TextStyle(
  ////     color: Color(0xFF161F1B),
  ////     fontSize: 20,
  ////     fontWeight: FontWeight.w400,
  ////   ),
  ////   iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  ////   centerTitle: true,
  //// ),  App bar theme on old
    // switchTheme: SwitchThemeData(
  //   trackColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Color(0xFF15B86C);
  //     }
  //     return Colors.white;
  //   }),
  //   thumbColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Colors.white;
  //     }
  //     return Color(0xFF9E9E9E);
  //   }),
  //   trackOutlineColor: WidgetStateColor.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Colors.transparent;
  //     }
  //     return Color(0xFF9E9E9E);
  //   }),
  //   trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return 0;
  //     }
  //     return 3;
  //   }),
  // ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColors.primaryColor,
      foregroundColor: Color(0xFFFFFCFC),
      textStyle: TextStyle(fontSize: 16 ,fontWeight: FontWeight.w400 ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.zero)
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color(0XFFC53030))
  ),
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: Color(0XFF15B86C),
  //   foregroundColor: Color(0XFFFFFCFC),
  //   extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  // ),
  // textTheme: TextTheme(
  //   displaySmall: TextStyle(
  //     fontSize: 24,
  //     fontWeight: FontWeight.w400,
  //     color: Color(0xFF161F1B),
  //   ),
  //   displayMedium: TextStyle(
  //     fontSize: 28,
  //     fontWeight: FontWeight.w400,
  //     color: Color(0xFF161F1B),
  //   ),
  //   displayLarge: TextStyle(
  //     fontSize: 32,
  //     fontWeight: FontWeight.w400,
  //     color: Color(0xFF161F1B),
  //   ),
  //   titleSmall: TextStyle(
  //     fontSize: 14,
  //     fontWeight: FontWeight.w400,
  //     color: Color(0xFF3A4640),
  //   ),
  //   titleMedium: TextStyle(
  //     fontSize: 16,
  //     fontWeight: FontWeight.w400,
  //     color: Color(0xFF161F1B),
  //   ),
  //   titleLarge: TextStyle(
  //     fontSize: 16,
  //     fontWeight: FontWeight.w400,
  //     decoration: TextDecoration.lineThrough,
  //     color: Color(0xFF6A6A6A),
  //     decorationColor: Color(0XFF49454F),
  //     overflow: TextOverflow.ellipsis,
  //   ),
  //   labelSmall: TextStyle(
  //     fontSize: 20,
  //     fontWeight: FontWeight.w400,
  //     color: Color(0XFF161F1B),
  //   ),
  //   labelLarge: TextStyle(color: Colors.black, fontSize: 24),
  //   labelMedium: TextStyle(color: Colors.black, fontSize: 16),
  // ),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius:BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    enabledBorder: InputBorder.none,
    focusColor: Color(0xFFD1DAD6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
  ),
  // checkboxTheme: CheckboxThemeData(
  //   side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadiusGeometry.zero,
  //   ),
  // ),
  // iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  // listTileTheme: ListTileThemeData(
  //   titleTextStyle: TextStyle(
  //     fontSize: 16,
  //     fontWeight: FontWeight.w400,
  //     color: Color(0xFF161F1B),
  //   ),
  // ),
  // dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6)),
  // textSelectionTheme: TextSelectionThemeData(
  //   cursorColor: Colors.black,
  //   selectionColor: Colors.white,
  //   selectionHandleColor: Colors.black,
  // ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor:  LightColors.backgroundColor,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0XFF363636),
    selectedItemColor: LightColors.primaryColor,
    showUnselectedLabels:true ,
  ),


);
