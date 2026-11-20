import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zihin_gunlugu/screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/notes_provider.dart';

void main() {
  runApp( 
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: ZihinGunluguApp(),
    ),
  );
}

class ZihinGunluguApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Zihin Günlüğü',
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
       home:  HomeScreen()
    );
  }
}
