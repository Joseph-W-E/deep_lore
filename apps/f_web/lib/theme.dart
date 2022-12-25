import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static const title = 'Deep Lore';

  static ThemeData make() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color.fromRGBO(179, 98, 70, 1),
      brightness: Brightness.dark,
      textTheme: _makeTextTheme(),
      drawerTheme: const DrawerThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  static TextTheme _makeTextTheme() {
    // todo differentiate between the various text theme slots
    final display = GoogleFonts.playfairDisplaySc();
    final title = GoogleFonts.libreBaskerville();
    final body = GoogleFonts.abhayaLibre();
    final label = body;
    return TextTheme(
      displayLarge: display,
      displayMedium: display,
      displaySmall: display,
      titleLarge: title,
      titleMedium: title,
      titleSmall: title,
      bodyLarge: body,
      bodyMedium: body,
      bodySmall: body,
      labelLarge: label,
      labelMedium: label,
      labelSmall: label,
    );
  }
}
