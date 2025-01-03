import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zihin_gunlugu/screens/home_screen.dart';
import 'package:zihin_gunlugu/widgets/bottom_nav_bar.dart';
import '../providers/notes_provider.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _nameController = TextEditingController();
  int _charCount = 0;
bool _isSaving = false;
  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _charCount = _nameController.text.length;
      });
    });
  }

  void _saveCategory() {
    final newCategoryName = _nameController.text.trim();
    if (newCategoryName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kategori adı boş bırakılamaz!')),
      );
      return;
    }
     if (_charCount > 25) {
      return;
    }

    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    if (notesProvider.categories.contains(newCategoryName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bu kategori zaten mevcut!')),
      );
      return;
    }

    notesProvider.addCategory(newCategoryName);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Kategori "$newCategoryName" başarıyla eklendi!')),
    );

    Navigator.push(
        context, (MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Kategori Ekle'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Kategori Adı',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${_charCount}/25',
                  style: TextStyle(
                    color: _charCount > 25 ? Colors.red : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveCategory,
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
      bottomNavigationBar:  BottomNavBar(currentIndex: -1, isSaving : _isSaving,),
    );
  }
 
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
