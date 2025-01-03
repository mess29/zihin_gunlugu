import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NotesProvider with ChangeNotifier {

  

  final List<String> _categories = [
    'Uzun Dönem Notlar',
    'Genel Notlar',
    'Rutin İşler',
    'Alışveriş Listesi'
  ];
  final List<Note> _notes = [];

  List<String> get categories => _categories;
  List<Note> get notes => _notes;

  bool _isGridView = false;
  bool get isGridView => _isGridView;

  

  void toggleViewMode() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  void addCategory(String categoryName) {
    if (!_categories.contains(categoryName)) {
      _categories.add(categoryName);
      notifyListeners();
    }
  }

  void deleteCategory(String categoryName) {
    _categories.remove(categoryName);
    _notes.removeWhere((note) => note.category == categoryName);
    notifyListeners();
  }

  void updateCategoryName(String oldName, String newName) {
    final categoryIndex = _categories.indexOf(oldName);
    if (categoryIndex != -1 && !_categories.contains(newName)) {
      _categories[categoryIndex] = newName;

      // Notların kategorisini de güncelle
      for (var note in _notes) {
        if (note.category == oldName) {
          note.category = newName;
        }
      }

      notifyListeners();
    }
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

   void updateNote(String id, Note updatedNote) {
    final noteIndex = _notes.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      _notes[noteIndex] = updatedNote;
      notifyListeners();
    }
  }

 

  void deleteNote(Note note) {
    _notes.removeWhere((existingNote) => existingNote.id == note.id);
    notifyListeners();
  }

  List<Note> getNotesByCategory(String category) {
    return _notes.where((note) => note.category == category).toList();
  }
}
