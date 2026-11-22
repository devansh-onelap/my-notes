import 'package:get/get.dart';
import 'package:my_notes/bindings/notes_bindings.dart';
import 'package:my_notes/routes/app_routes.dart';
import 'package:my_notes/screens/note_screen.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.notes;

  static final pages = <GetPage>[
    GetPage(
      name: Routes.notes,
      page: () => NoteScreen(),
      binding: NotesBinding(),
    ),
  ];
}