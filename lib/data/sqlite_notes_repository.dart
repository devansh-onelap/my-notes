import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_notes/data/notes_repository.dart';
import 'package:my_notes/models/note.dart';

class SqliteNotesRepository implements NotesRepository {
  static const _databaseName = 'my_notes.db';
  static const _databaseVersion = 1;
  static const _tableNotes = 'notes';

  Database? _database;

  // ---------- Connection ----------
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableNotes (
        id            TEXT    PRIMARY KEY,
        title         TEXT    NOT NULL,
        description   TEXT    NOT NULL,
        creation_date TEXT    NOT NULL,
        is_favourite  INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // ---------- The contract methods ----------

  @override
  Future<List<Note>> getAllNotes() async {
    final db = await database;
    final rows = await db.query(_tableNotes, orderBy: 'id ASC');
    return rows.map((row) => Note.fromMap(row)).toList();
  }

  @override
  Future<void> insertNote(Note note) async {
    final db = await database;
    await db.insert(_tableNotes, note.toMap());
  }

  @override
  Future<void> updateNote(Note note) async {
    final db = await database;
    await db.update(
      _tableNotes,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  @override
  Future<void> deleteNote(String id) async {
    final db = await database;
    await db.delete(_tableNotes, where: 'id = ?', whereArgs: [id]);
  }
}