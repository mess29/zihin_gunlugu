import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zihin_gunlugu/widgets/bottom_nav_bar.dart';
import '../providers/notes_provider.dart';
import '../models/note_model.dart';
import 'category_notes_screen.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedCategory;
  bool _isSaving = false;
  String _selectedImportance = 'low';

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NotesProvider>(context).categories;

    return Scaffold(
  
      appBar: AppBar(
        title: const Text('Yeni Not Ekle'),
      ),
      body: SingleChildScrollView(

        child: /* Builder(
          builder:(context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight!,
              ),
              child:  */Padding(
                padding: const EdgeInsets.all(4.0),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kategori',
                        ),
                        items: categories.map((
                          category,
                        ) {
                          return DropdownMenuItem(
                              value: category,
                              child: Text(
                                category,
                              ));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                        selectedItemBuilder: (context) {
                          return categories.map((category) {
                            return Text(
                              category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            );
                          }).toList();
                        },
                      ),
                      if (selectedCategory != 'Uzun Dönem Notlar') ...[
                        const Text('Önem Derecesi', style: TextStyle(fontSize: 16)),
                        DropdownButton<String>(
                          value: _selectedImportance,
                          items: [
                            DropdownMenuItem(
                                value: 'high',
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 10,
                                    ),
                                    Text(' Kırmızı (Önemli)'),
                                  ],
                                )),
                            DropdownMenuItem(
                                value: 'medium',
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.yellow,
                                      radius: 10,
                                    ),
                                    Text(' Sarı (Orta)'),
                                  ],
                                )),
                            DropdownMenuItem(
                                value: 'low',
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 10,
                                    ),
                                    Text(' Yeşil (Normal)'),
                                  ],
                                )),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedImportance = value!;
                            });
                          },
                        ),
                      ],
                      const SizedBox(height: 16),
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Başlık',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Flexible(
                      //  fit: FlexFit.loose,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Açıklama',
                          ),
                          maxLines: 10,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: () {
                          final title = _titleController.text.trim();
                          final description = _descriptionController.text.trim();
                  
                          if (title.isEmpty || selectedCategory == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Tüm alanları doldurun!')),
                            );
                            return;
                          }
                  
                          final newNote = Note(
                            id: DateTime.now().toString(),
                            title: title,
                            description: description,
                            category: selectedCategory!,
                            importance: _selectedImportance,
                          );
                  
                          Provider.of<NotesProvider>(context, listen: false)
                              .addNote(newNote);
                  
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Not başarıyla eklendi!')),
                          );
                  
                            Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryNotesScreen(category: selectedCategory!),
                            ),
                            (Route<dynamic> route) => false,
                            );
                        },
                        child: const Text('Kaydet'),
                      ),
                    ],
                  ),
                ),
              ),
   /*          ),
          ),
        ),
      ), */
     ), bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        isSaving: _isSaving,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
