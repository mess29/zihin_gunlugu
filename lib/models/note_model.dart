class Note {
  final String id;
   String title;
   String description;
   String category;
   String importance;
  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.importance,
 
  });

  Note copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? importance,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      importance: importance ?? this.importance,
    );
  }
}
