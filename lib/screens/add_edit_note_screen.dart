import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zihin_gunlugu/utils/dialog_utils.dart';
import 'package:zihin_gunlugu/widgets/bottom_nav_bar.dart';
import '../providers/notes_provider.dart';
import '../models/note_model.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  _AddEditNoteScreenState createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  bool _isSaving = false;
  Timer? _debounce;
  String _selectedImportance = 'low';

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _titleController.text = widget.note!.title;
          _descriptionController.text = widget.note!.description;
          _selectedCategory = widget.note!.category;
          _selectedImportance = widget.note!.importance;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NotesProvider>(context).categories;

    return WillPopScope(
      onWillPop: () async {
        if (_isSaving) {
          final shouldExit = await showExitConfirmationDialog(context);
          return shouldExit;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notu Düzenle'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(labelText: 'Kategori'),
                    items: categories
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                      _saveNoteAutomatically(value!);
                    },
                  ),
                  if (_selectedCategory != 'Uzun Dönem Notlar') ...[
                    const Text('Önem Derecesi', style: TextStyle(fontSize: 16)),
                    DropdownButton<String>(
                      value: _selectedImportance,
                      items: [
                        DropdownMenuItem(
                            value: 'high', child: Text('Kırmızı (Önemli)')),
                        DropdownMenuItem(
                            value: 'medium', child: Text('Sarı (Orta)')),
                        DropdownMenuItem(
                            value: 'low', child: Text('Yeşil (Normal)')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedImportance = value!;
                        });
                        _saveNoteAutomatically(value!);
                      },
                    ),
                  ],
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Başlık'),
                    onChanged: (value) {
                      /* if (widget.note != null) {
                        Provider.of<NotesProvider>(context, listen: false).updateNote(
                          widget.note!.id,
                          widget.note!.copyWith(title: value),
                        );
                      } */
                      _saveNoteAutomatically(value);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: 'Açıklama'),
                      maxLines: 15,
                      onChanged: (value) {
                        /* if (widget.note != null) {
                          Provider.of<NotesProvider>(context, listen: false)
                              .updateNote(
                            widget.note!.id,
                            widget.note!.copyWith(description: value),
                          );
                        }
                   */
                        _saveNoteAutomatically(value);
                      },
                    ),
                  ),
                  /* if (_isSaving)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Kaydediliyor...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ) */
                  /*  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.isEmpty ||
                          _selectedCategory == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tüm alanları doldurun.')),
                        );
                        return;
                      }
                  
                      final newNote = Note(
                        id: widget.note?.id ?? DateTime.now().toString(),
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim(),
                        category: _selectedCategory!,
                      );
                  
                      if (widget.note == null) {
                        Provider.of<NotesProvider>(context, listen: false)
                            .addNote(newNote);
                      } else {
                        Provider.of<NotesProvider>(context, listen: false)
                            .updateNote(newNote.id, newNote);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Kaydet'),
                  ), */
                ],
              ),
            ),
          ),
        ),
           bottomNavigationBar: BottomNavBar(currentIndex: -1, isSaving: _isSaving,),
      ),
    );
  }

  void _saveNoteAutomatically(String text ) {
    if (widget.note != null &&
        widget.note!.title == _titleController.text.trim() &&
        widget.note!.description == _descriptionController.text.trim() &&
        widget.note!.category == _selectedCategory &&
        widget.note!.importance == _selectedImportance) {
      return; // Mevcut notta değişiklik yapılmadıysa kaydetme işlemi yapma
    }
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(Duration(seconds: 0), () {
      if (widget.note != null) {
        // Mevcut bir not düzenleniyorsa, güncelle
        Provider.of<NotesProvider>(context, listen: false).updateNote(
          widget.note!.id,
          widget.note!.copyWith(
            category: _selectedCategory,
            importance: _selectedImportance,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
          ),
        );
      } else {
        // Yeni bir not ekleniyorsa, ekle
        final newNote = Note(
          id: DateTime.now().toString(),
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          category: _selectedCategory!,
          importance: _selectedImportance,
        );
        Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
      }
      setState(() {
        _isSaving = false;
      });
    /*   ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Değişiklikler kaydedildi.')),
      ); */
    });

    setState(() {
      _isSaving = true;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }
}
