import 'package:flutter/material.dart';
import 'package:zihin_gunlugu/screens/add_note_screen.dart';
import 'package:zihin_gunlugu/screens/home_screen.dart';
import 'package:zihin_gunlugu/screens/my_notes_screen.dart';
import 'package:zihin_gunlugu/screens/settings_screen.dart';
import 'package:zihin_gunlugu/utils/dialog_utils.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final bool isSaving;

  const BottomNavBar(
      {Key? key, required this.currentIndex, required this.isSaving, re})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex < 0 ? 0 : currentIndex,
        backgroundColor: Colors.transparent,
        selectedItemColor: selectedColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) async {
          if (currentIndex == index)
            return; // Aynı sayfaya geçmeye çalışıyorsa işlem yapma

          if (isSaving) {
            // Kaydetme işlemi varsa
            final shouldExit = await showExitConfirmationDialog(context);
            if (!shouldExit) return; // Çıkmak istemezse işlemi durdur
          }
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyNotesScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AddNoteScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
