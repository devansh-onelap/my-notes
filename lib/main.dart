import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/cubits/notes_cubit.dart';
import 'package:my_notes/cubits/theme_cubit.dart';
import 'package:my_notes/cubits/user_name_cubit.dart';
import 'package:my_notes/data/hive_notes_repository.dart';
import 'package:my_notes/data/notes_repository.dart';
import 'package:my_notes/data/settings_repository.dart';
import 'package:my_notes/routes/app_router.dart';
import 'package:my_notes/routes/app_routes.dart';
import 'package:my_notes/themes/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveNotesRepository.init();
  final prefs = await SharedPreferences.getInstance();

  runApp(MyNotesApp(settingsRepository: SettingsRepository(prefs)));
}

class MyNotesApp extends StatelessWidget {
  const MyNotesApp({super.key, required this.settingsRepository});
  final SettingsRepository settingsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NotesRepository>(
          create: (_) => HiveNotesRepository(),
        ),
        RepositoryProvider<SettingsRepository>.value(
          value: settingsRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            NotesCubit(context.read<NotesRepository>())..loadNotes(),
          ),
          BlocProvider(
            create: (context) =>
                ThemeCubit(context.read<SettingsRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                UserNameCubit(context.read<SettingsRepository>()),
          ),
        ],
        child: BlocBuilder<ThemeCubit, bool>(
          builder: (context, isDark) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My Notes',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            initialRoute: AppRoutes.home,
            onGenerateRoute: AppRouter.onGenerateRoute,
            onUnknownRoute: AppRouter.onUnknownRoute,
          ),
        ),
      ),
    );
  }
}