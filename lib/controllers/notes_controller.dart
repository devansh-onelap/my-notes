import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/models/note.dart';

class NotesController extends GetxController {

  final notes = <Note>[
    Note(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: "Flutter Learning test anotherdjfkdsk fldsajkf jldsjf adsjlkfdjkla test",
        description: "Learning Flutter fundamentals dfjkajkdfakl df dfa dfadfajkajkdfakl tdfjkajkdfakl test",
        creationDate: "14 Nov 2026",
        isFavourite: true
    ),
    Note(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: "Daily Tasks",
      description: "Complete today's goals",
      creationDate: "13 Nov 2026",
    ),
  ].obs;

  bool isGridView = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void toggleView() {
    isGridView = !isGridView;
    update(["viewMode"]);
  }

  String? addNote() {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      return "title or description cannot be empty";
    }

    notes.add(Note(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      creationDate: _getCurrentDate(),
      title: title,
      description: description,
      isFavourite: false
    ));

    clearForm();
    return null;
  }

  String _getCurrentDate() {
    return DateFormat("d MMM yyyy").format(DateTime.now());
  }

  String? editNote(String id) {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();

    final index = notes.indexWhere((n) => n.id == id);
    if (index == -1) return "Note not found with id: $id";

    if (title.isEmpty || description.isEmpty) {
      return "title or description cannot be empty";
    }

    notes[index] = notes[index].copyWith(
      title: title,
      description: description
    );

    clearForm();
    return null;
  }

  void deleteNote(String id) {
    final index = notes.indexWhere((n) => n.id == id);
    if (index == -1) return;
    notes.removeAt(index);
  }

  void toggleFavourite(String id) {
    final index = notes.indexWhere((n) => n.id == id);
    if (index == -1) return;

    notes[index] = notes[index].copyWith(isFavourite: !notes[index].isFavourite);
  }

  void loadNoteForEditing(String id) {
    final index = notes.indexWhere((n) => n.id == id);
    if (index == -1) return;

    Note note = notes[index];
    titleController.text = note.title;
    descriptionController.text = note.description;
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
  }

  List<Note> get favouriteNotes => notes.where((n) => n.isFavourite).toList();
  int get favouriteCount => favouriteNotes.length;

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

}