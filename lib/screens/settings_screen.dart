import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zihin_gunlugu/widgets/bottom_nav_bar.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  bool _isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tema Ayarları',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: const Text('Açık Tema'),
              trailing: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: Provider.of<ThemeProvider>(context).themeMode,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setThemeMode(value!);
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Koyu Tema'),
              trailing: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: Provider.of<ThemeProvider>(context).themeMode,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setThemeMode(value!);
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.brightness_auto),
              title: const Text('Sistem Teması'),
              trailing: Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: Provider.of<ThemeProvider>(context).themeMode,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setThemeMode(value!);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3, isSaving : _isSaving,),
    );
  }
}
