class Category {
  final String name; // Kategorinin adı
  

  Category({
    required this.name,
   
  });

 
  // Bir kategori nesnesini Map'e dönüştürmek için kullanılır (Veritabanı işlemleri için)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
     
    };
  }

  // Map'ten bir kategori nesnesi oluşturmak için kullanılır (Veritabanı işlemleri için)
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
     
    );
  }
}
