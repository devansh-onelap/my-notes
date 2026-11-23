import 'package:get/get.dart';
import 'package:my_notes/controllers/notes_controller.dart';
import 'package:my_notes/data/hive_notes_repository.dart';
import 'package:my_notes/data/notes_repository.dart';
import 'package:my_notes/data/sqlite_notes_repository.dart';

class NotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotesRepository>(() => HiveNotesRepository());

    Get.lazyPut<NotesController>(
          () => NotesController(Get.find<NotesRepository>()),
    );
  }
}