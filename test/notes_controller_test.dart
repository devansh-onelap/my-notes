import 'package:flutter_test/flutter_test.dart';
import 'package:my_notes/controllers/notes_controller.dart';

void main() {
  test("addNote rejects empty title", () {
    final c = NotesController();
    c.titleController.text = '';
    c.descriptionController.text = "something";
    expect(c.addNote(), isNotNull);
  });

  test('adding a note notifies listeners', () async {
    final c = NotesController();
    var notifications = 0;
    c.notes.listen((_) => notifications++);

    c.titleController.text = 'Title';
    c.descriptionController.text = 'Desc';
    c.addNote();
    await Future.delayed(Duration.zero);

    expect(c.notes.length, 3);
    expect(notifications, 1);
  });
}