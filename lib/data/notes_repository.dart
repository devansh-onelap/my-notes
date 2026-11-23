import 'package:my_notes/models/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getAllNotes();
  Future<void> insertNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String id);
}