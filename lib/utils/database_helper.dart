import '../models/note_model.dart';
import '../models/category_model.dart';

class DatabaseHelper {
  static final List<Note> _notes = [];
  static final List<Category> _categories = [
    Category(name: 'Uzun Dönem Notlar',),
    Category(name: 'Kısa Dönem Notlar',),
    Category(name: 'Genel Notlar',),
    Category(name: 'Rutin İşler',),
    Category(name: 'Alışveriş Listeleri',),
  ];

  

  // Notlarla ilgili işlemler
  static Future<void> addNote(Note note) async {
    _notes.add(note);
  }

  static Future<List<Note>> getNotes() async {
    return _notes;
  }

  static Future<void> deleteNote(int index) async {
    _notes.removeAt(index);
  }

  // _notes'a erişim için bir getter ekleyelim
  static List<Note> get notes => _notes;

  // Kategorilerle ilgili işlemler
  static Future<void> addCategory(Category category) async {
    _categories.add(category);
  }

  static Future<List<Category>> getCategories() async {
    return _categories;
  }

  static List<Category> get categories => _categories; // Kategorilere erişim için getter
}
