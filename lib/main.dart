import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_notes/cubits/notes_cubit.dart';
import 'package:my_notes/data/hive_notes_repository.dart';
import 'package:my_notes/data/notes_repository.dart';
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
    RepositoryProvider<NotesRepository>(
      create: (_) => HiveNotesRepository(),
      // create: (_) => SqliteNotesRepository(),

      child: BlocProvider<NotesCubit>(
        create: (context) =>
        NotesCubit(context.read<NotesRepository>())..loadNotes(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Notes",
          initialRoute: AppPages.initial,
          getPages: AppPages.pages,
          theme: ThemeData(fontFamily: 'Poppins'),
        ),
      ),
    ),
  );
}