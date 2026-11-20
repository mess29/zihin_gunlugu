import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zihin_gunlugu/screens/add_edit_note_screen.dart';
import 'package:zihin_gunlugu/widgets/bottom_nav_bar.dart';
import '../providers/notes_provider.dart';

class CategoryNotesScreen extends StatefulWidget {
  final String category;

  const CategoryNotesScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryNotesScreen> createState() => _CategoryNotesScreenState();
}

class _CategoryNotesScreenState extends State<CategoryNotesScreen> {
  late String currentCategoryName;
  final TextEditingController _categoryNameController = TextEditingController();
  bool isEditing = false;
bool _isSaving = false;
  @override
  void initState() {
    super.initState();
    currentCategoryName = widget.category;
    _categoryNameController.text = currentCategoryName;
  }

  void _saveCategoryName() {
    final newCategoryName = _categoryNameController.text.trim();
    if (newCategoryName.isNotEmpty && newCategoryName != currentCategoryName) {
      Provider.of<NotesProvider>(context, listen: false)
          .updateCategoryName(currentCategoryName, newCategoryName);

      setState(() {
        currentCategoryName = newCategoryName;
        isEditing = false;
      });
    }
  }
    @override
    Widget build(BuildContext context) {
      final notesProvider = Provider.of<NotesProvider>(context);
      //final notes = notesProvider.getNotesByCategory(currentCategoryName);

      return Scaffold(
        appBar: AppBar(
          title: isEditing ? TextField(
            controller: _categoryNameController,
            decoration: InputDecoration(
              hintText: 'Kategori Adı',
              border: InputBorder.none,
            ),
            onSubmitted: (_) => _saveCategoryName(),
          ) 
          : Text(currentCategoryName),
          centerTitle: true,
          actions: [
          IconButton(onPressed: (){
            if(isEditing){
              _saveCategoryName();
            }else {
              setState(() {
                isEditing = true;
              });
            }
          }, icon: Icon(isEditing ? Icons.check : Icons.edit),)
          ],
        ),

        body: Consumer<NotesProvider>(
          builder: (context, provider, _) {
            final notes = provider.getNotesByCategory(widget.category);
            final availableHeight = MediaQuery.of(context).size.height -
                Scaffold.of(context).appBarMaxHeight! -
                kBottomNavigationBarHeight;

            if (widget.category == 'Uzun Dönem Notlar') {
              return notes.isEmpty
                  ? const Center(
                      child: Text('Bu kategoride henüz not eklenmedi.'))
                  : ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return SizedBox(
                          height: availableHeight / 2,
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: /* Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  note.description,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                
                              ],
                            ), */
                                  ListTile(
                                title: Text(note.title),
                                subtitle: Text(
                                  note.description,
                                  maxLines: 5,
                                  overflow:
                                      TextOverflow.ellipsis, // Taşan metni kes
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddEditNoteScreen(note: note),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
            } else {
              return notes.isEmpty
                  ? const Center(
                      child: Text('Bu kategoride henüz not eklenmedi.'),
                    )
                  : provider.isGridView
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            final note = notes[index];
                            return Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      note.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(note.description),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            final note = notes[index];
                            return ListTile(leading: CircleAvatar(backgroundColor: note.importance == 'high'
                  ? Colors.red :note.importance == 'medium' ? Colors.yellow : Colors.green, radius: 8,
                  ),
                              title: Text(note.title),
                              subtitle: Text(
                                note.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  notesProvider.deleteNote(note);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Not silindi')),
                                  );
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddEditNoteScreen(
                                              note: note,
                                            )));
                              },
                            );
                          },
                        );
            }
          },
        ),
        bottomNavigationBar: BottomNavBar(currentIndex: -1, isSaving : _isSaving,),
      );
    }
      
@override
  void dispose() {
   _categoryNameController.dispose();
    super.dispose();
  }
    }

