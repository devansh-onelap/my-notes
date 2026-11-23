import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/data/notes_repository.dart';
import 'package:my_notes/models/note.dart';

class NotesController extends GetxController {
  NotesController(this._repository);
  final NotesRepository _repository;

  final notes = <Note>[].obs;
  final isLoading = true.obs;

  bool isGridView = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // load notes when the controller starts
  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  Future<void> loadNotes() async {
    isLoading.value = true;
    try {
      notes.assignAll(await _repository.getAllNotes());
    } catch (e) {
      print(' Failed to load notes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleView() {
    isGridView = !isGridView;
    update(["viewMode"]);
  }

  Future<String?> addNote() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      return "title or description cannot be empty";
    }

    final note = Note(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      creationDate: _getCurrentDate(),
      title: title,
      description: description,
    );

    try {
      await _repository.insertNote(note);
    } catch (e) {
      return "Could not save note: $e";
    }
    notes.add(note);

    clearForm();
    return null;
  }

  String _getCurrentDate() {
    return DateFormat("d MMM yyyy").format(DateTime.now());
  }

  Future<String?> editNote(String id) async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    final index = notes.indexWhere((n) => n.id == id);
    if (index == -1) return "Note not found with id: $id";

    if (title.isEmpty || description.isEmpty) {
      return "title or description cannot be empty";
    }

    final updated = notes[index].copyWith(title: title, description: description);

    try {
      await _repository.updateNote(updated);
    } catch (e) {
      return "Could not update note: $e";
    }
    notes[index] = updated;

    clearForm();
    return null;
  }

  Future<void> deleteNote(String id) async {
    await _repository.deleteNote(id);
    notes.removeWhere((n) => n.id == id);
  }

  Future<void> toggleFavourite(String id) async {
    final index = notes.indexWhere((n) => n.id == id);
    if (index == -1) return;

    final updated = notes[index].copyWith(isFavourite: !notes[index].isFavourite);
    await _repository.updateNote(updated);
    notes[index] = updated;
  }

  void loadNoteForEditing(String id) {
    final index = notes.indexWhere((n) => n.id == id);
    if (index == -1) return;

    final note = notes[index];
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