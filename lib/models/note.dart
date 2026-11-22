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
    this.isFavourite = false
  });

  Note copyWith({String? title, String? description, bool? isFavourite}) {
    return Note(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFavourite: isFavourite ?? this.isFavourite,
      creationDate: creationDate
    );
  }
}