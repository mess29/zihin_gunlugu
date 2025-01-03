import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/my_notes_screen.dart';
import '../screens/add_edit_note_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/category_notes_screen.dart';
import '../screens/add_category_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) =>  HomeScreen(initialCategory: "",));

      case '/notes':
        return MaterialPageRoute(builder: (_) =>  MyNotesScreen());

      case '/add-note':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => AddEditNoteScreen(note: args?['note']),
        );

      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());

      case '/category-notes':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => CategoryNotesScreen(
            category: args?['category'] ?? 'Genel Notlar',
          ),
        );

      case '/add-category':
        return MaterialPageRoute(builder: (_) => AddCategoryScreen());
        

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Sayfa bulunamadı!')),
          ),
        );
    }
  }
}
