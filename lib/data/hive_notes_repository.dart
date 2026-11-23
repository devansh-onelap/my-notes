import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:my_notes/data/note_adapter.dart';
import 'package:my_notes/data/notes_repository.dart';
import 'package:my_notes/models/note.dart';

class HiveNotesRepository implements NotesRepository {
  static const _boxName = 'notes';

  // ---------- Setup: call ONCE in main(), before runApp ----------
  static Future<void> init() async {
    await Hive.initFlutter();                  // 1. where to store
    Hive.registerAdapter(NoteAdapter());       // 2. how to store a Note
    await Hive.openBox<Note>(_boxName);        // 3. load the box into memory
  }

  // The already-open box (instant, no await)
  Box<Note> get _box => Hive.box<Note>(_boxName);

  // ---------- The contract methods ----------

  @override
  Future<List<Note>> getAllNotes() async {
    final list = _box.values.toList();
    list.sort((a, b) => a.id.compareTo(b.id));
    return list;
  }

  @override
  Future<void> insertNote(Note note) async {
    await _box.put(note.id, note);               // key = note's own id
  }

  @override
  Future<void> updateNote(Note note) async {
    await _box.put(note.id, note);               // put = insert OR replace
  }

  @override
  Future<void> deleteNote(String id) async {
    await _box.delete(id);
  }
}