class Note {
  String title;
  String description;
  String creationDate;
  bool isFavourite;

  Note({
    required this.title,
    required this.description,
    required this.creationDate,
    this.isFavourite = false
  });
}