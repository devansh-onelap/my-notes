import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/data/hive_notes_repository.dart';
import 'package:my_notes/routes/app_pages.dart';
import 'package:my_notes/screens/note_screen.dart';

// void main() {
//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Notes",
//       initialRoute: AppPages.initial,
//       getPages: AppPages.pages,
//       theme: ThemeData(fontFamily: 'Poppins'),
//     ),
//   );
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveNotesRepository.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Notes",
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
      theme: ThemeData(fontFamily: 'Poppins'),
    ),
  );
}