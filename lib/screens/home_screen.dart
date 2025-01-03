import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zihin_gunlugu/providers/notes_provider.dart';
import 'package:zihin_gunlugu/providers/theme_provider.dart';
import 'package:zihin_gunlugu/screens/add_category_screen.dart';
import 'package:zihin_gunlugu/screens/category_notes_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
 final String? initialCategory;

   HomeScreen({this.initialCategory});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDeleteMode = false;
  // final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  bool _isSearchActive = false;
  bool _isSaving = false;


  _HomeScreenState();
  @override
  Widget build(BuildContext context) {
    // final categories = Provider.of<NotesProvider>(context).categories;
    final notesProvider = Provider.of<NotesProvider>(context);
    final categories = notesProvider.categories
        .where((category) =>
            category.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      /* appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearchActive = !_isSearchActive;
              });
            },
          ),
          if (_isSearchActive)
            Expanded(
              child: Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Material(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Kategori Ara...',
                        // prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              _searchText = '';
                              _isSearchActive = false;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ), */

       resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(title: Text("Ana Sayfa")),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _isSearchActive = !_isSearchActive;
                        });
                      },
                    ),
                    if (_isSearchActive)
                      Expanded(
                        child: Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Material(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                autofocus: true,
                                onChanged: (value) {
                                  setState(() {
                                    _searchText = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Kategori Ara...',
                                  // prefixIcon: const Icon(Icons.search),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.cancel),
                                    onPressed: () {
                                      setState(() {
                                        _searchText = '';
                                        _isSearchActive = false;
                                      });
                                    },
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
              title: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCategoryScreen()),
                    );
                  },
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text('Kategori Ekle'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red[200],
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isDeleteMode = !isDeleteMode;
                  });
                },
                icon: Icon(
                    isDeleteMode
                        ? Icons.cancel_rounded
                        : Icons.remove_red_eye_rounded,
                    color: Colors.red[400]),
              ),
            ],
          )),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.25,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryNotesScreen(category: category),
                                  ),
                                );
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Kategori Detayı'),
                                      content: SingleChildScrollView(
                                        child: Text(
                                          category, // Kategori ismi burada gösterilecek
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Kapat'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.all(8),
                                child: Container(
                                  decoration: CardStyles.categoryCardStyle,
                                  child: Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      category,
                                      style: CardStyles.categoryTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (isDeleteMode)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Kategori Sil'),
                                          content: Text(
                                                "$category kategorisi içindeki (${notesProvider.getNotesByCategory(category).length}) not ile birlikte silinecek. Silmek istediğinize emin misiniz?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: Text('Hayır'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: Text("Evet"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    setState(() {
                                      if (confirm == true) {
                                        Provider.of<NotesProvider>(context,
                                                listen: false)
                                            .deleteCategory(category);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text("$category silindi!")),
                                        );
                                      }
                                    });
                                  },
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
      
          /* Expanded(
            child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ListTile(
                    title: Text(category),
                    trailing: isDeleteMode
                        ? IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Kategori Sil"),
                                      content: Text(
                                          "$category kategorisini silmek istediğinize emin misiniz?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text("Hayır"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: Text("Evet"),
                                        ),
                                      ],
                                    );
                                  });
                              if (confirm == true) {
                                Provider.of<NotesProvider>(context,
                                        listen: false)
                                    .deleteCategory(category);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("$category silindi!")),
                                );
                              }
                            },
                          )
                        : null,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CategoryNotesScreen(category: category)));
                    },
                  );
                }),
          ), */
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        isSaving: _isSaving,
      ),
    );
  }
}
