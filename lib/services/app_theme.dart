import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
static var  backGroundWidget = Colors.grey[300] ;
static const List <Color> backGroundScreen = [
Color(0xFFA91E1E),
Color(0xFFE32D2D),
Color(0xFF580000),

];

  static ThemeData appTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.cairo().fontFamily,
      primarySwatch: Colors.red,
      primaryColor: Colors.red,
      appBarTheme: appBarTheme(),
    );
  }

 static AppBarTheme appBarTheme() {
    return AppBarTheme(
      backgroundColor: Colors.red,
      elevation: 0,
      centerTitle: true,
    );
  }
}