import 'package:hive_ce/hive_ce.dart';
import 'package:my_notes/models/note.dart';

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0;

  static const _id = 0;
  static const _title = 1;
  static const _description = 2;
  static const _creationDate = 3;
  static const _isFavourite = 4;

  @override
  void write(BinaryWriter writer, Note obj) {
    writer.writeByte(5);                              // number of fields

    writer.writeByte(_id);           writer.write(obj.id);
    writer.writeByte(_title);        writer.write(obj.title);
    writer.writeByte(_description);  writer.write(obj.description);
    writer.writeByte(_creationDate); writer.write(obj.creationDate);
    writer.writeByte(_isFavourite);  writer.write(obj.isFavourite);
  }

  @override
  Note read(BinaryReader reader) {
    final fieldCount = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < fieldCount; i++) {
      fields[reader.readByte()] = reader.read();
    }

    return Note(
      id: fields[_id] as String,
      title: fields[_title] as String,
      description: fields[_description] as String,
      creationDate: fields[_creationDate] as String,
      isFavourite: fields[_isFavourite] as bool? ?? false,
    );
  }
}