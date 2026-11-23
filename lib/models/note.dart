class Note {
  final String id;
  final String title;
  final String description;
  final String creationDate;
  final bool isFavourite;

  const Note({
    required this.id,
    required this.title,
    required this.description,
    required this.creationDate,
    this.isFavourite = false,
  });

  Note copyWith({String? title, String? description, bool? isFavourite}) {
    return Note(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFavourite: isFavourite ?? this.isFavourite,
      creationDate: creationDate,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creation_date': creationDate,
      'is_favourite': isFavourite ? 1 : 0,
    };
  }

  factory Note.fromMap(Map<String, Object?> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      creationDate: map['creation_date'] as String,
      isFavourite: map['is_favourite'] == 1,
    );
  }
}