import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFFF6B6B); // Canlı kırmızı
  static const Color secondaryColor = Color(0xFFFFE66D); // Pastel sarı
  static const Color lightBackground = Color(0xFFF7FFF7); // Açık arka plan
  static const Color darkBackground = Color(0xFF22223B); // Koyu arka plan
  static const Color textPrimary = Color(0xFF000000); // Siyah metin
  static const Color textSecondary = Color(0xFF6B6B6B); // Gri metin
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.roboto(
          fontSize: 16,
          color: AppColors.textSecondary,
        ),
      ),
      cardColor: AppColors.lightBackground,
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary),
        bodyLarge:
            GoogleFonts.roboto(fontSize: 16, color: AppColors.textSecondary),
      ),
      cardColor: AppColors.darkBackground,
    );
  }

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}

class CardStyles {
  static BoxDecoration categoryCardStyle = BoxDecoration(
       color: AppColors.lightBackground,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    );

    static TextStyle categoryTextStyle = GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,

    );
  }

