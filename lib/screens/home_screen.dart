import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/cubits/note_state.dart';
import 'package:my_notes/cubits/notes_cubit.dart';
import 'package:my_notes/cubits/theme_cubit.dart';
import 'package:my_notes/cubits/user_name_cubit.dart';
import 'package:my_notes/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openNotes(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.notes);
  }

  void _showEditNameDialog(BuildContext context, String currentName) {
    var newName = currentName;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Your name'),
        content: TextFormField(
          initialValue: currentName,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter your name'),
          onChanged: (value) => newName = value,
        ),
        actions: [
          FilledButton(
            onPressed: () {
              context.read<UserNameCubit>().saveName(newName);
              Navigator.pop(dialogContext);
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          BlocBuilder<ThemeCubit, bool>(
            builder: (context, isDark) => IconButton(
              tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<UserNameCubit, String>(
              builder: (context, name) => Row(
                children: [
                  Expanded(
                    child: Text(
                      name.isEmpty ? 'Hello there!' : 'Hello, $name!',
                      style: textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Edit name',
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditNameDialog(context, name),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<NotesCubit, NoteState>(
              builder: (context, state) => Text(
                'You have ${state.notes.length} notes & ${state.favouriteCount} favourites',
                style: textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: const Icon(Icons.notes),
                label: const Text('Open my notes'),
                onPressed: () => _openNotes(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}