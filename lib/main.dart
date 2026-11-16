import 'package:material_ui/material_ui.dart';
import 'package:my_notes/note_screen.dart';
import 'note_card.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Notes",
      home: NoteScreen(),
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
    ),
  );
}