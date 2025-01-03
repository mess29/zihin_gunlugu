import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zihin_gunlugu/screens/add_edit_note_screen.dart';
import 'package:zihin_gunlugu/widgets/bottom_nav_bar.dart';
import '../providers/notes_provider.dart';

class MyNotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    final notes = notesProvider.notes;
bool _isSaving = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notlarım'),
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text('Henüz not eklenmedi.'),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  leading: CircleAvatar(backgroundColor: note.importance == 'high'
                  ? Colors.red :note.importance == 'medium' ? Colors.yellow : Colors.green, radius: 8,
                  ),
                  title: Text(note.title),
                  subtitle: Text(
                    note.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      notesProvider.deleteNote(note);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Not silindi')),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditNoteScreen(note: note),
                      ),
                    );
                  },
                );
              },
            ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1, isSaving : _isSaving,),
    );
  }
}
