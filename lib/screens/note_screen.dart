import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/controllers/notes_controller.dart';
import 'package:my_notes/cubits/note_state.dart';
import 'package:my_notes/cubits/notes_cubit.dart';
import 'package:my_notes/models/note.dart';
import 'package:my_notes/widgets/favourite_badge.dart';
import 'package:my_notes/widgets/note_card.dart';
import 'package:my_notes/widgets/note_dialog.dart';

class NoteScreen extends GetView<NotesController> {
  const NoteScreen({super.key});

  void _cancelNote(BuildContext context) {
    Navigator.pop(context);
  }

  void _showDeleteConfirmationDialog(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete note"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Are you sure you want to delete the note?"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<NotesCubit>().deleteNote(note.id);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontWeight: FontWeight(700)
                      )
                    ),
                    child: Text("Delete"),
                  ),
                  SizedBox(width: 6,),
                  ElevatedButton(
                    onPressed: () {
                      _cancelNote(context);
                    },
                    child: Text("Cancel"),
                  )
                ],
              )
            ],
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    print("Note screen build method");

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
          title: SizedBox(
            height: 74,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/notes_logo.png",
                          width: 32,
                          height: 32,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 12,),
                        Text("My Notes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                    FavouriteBadge()
                  ],
                ),
                SizedBox(height: 3),
                Text("Your thoughts, all in one place", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
              ],
            ),
          ),
          backgroundColor: Color(0xfa59eae5)
      ),
      body: BlocBuilder<NotesCubit, NoteState>(
        builder: (context, state) {

          // initial or loading -> spinner
          if (state.status == NoteStatus.initial || state.status == NoteStatus.loading) {
            return const Center(child: CircularProgressIndicator(),);
          }

          // failure and list isEmpty -> error message + Retry button
          if (state.status == NoteStatus.failure && state.notes.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${state.errorMessage}"),
                  ElevatedButton(
                    onPressed: () => context.read<NotesCubit>().loadNotes(),
                    child: Text("Retry"),
                  )
                ],
              ),
            );
          }

          if (state.notes.isEmpty) {
            return Center(
              child: Text("Press + to create notes!"),
            );
          }

          return screenWidth < 600?
            ListView.builder(
              itemCount: state.notes.length,
              padding: EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return _buildCard(context, note);
              },
            ) :
            GridView.builder(
              itemCount: state.notes.length,
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 160,
              ),
              itemBuilder: (context, index) {
                final note = state.notes[index];

                return _buildCard(context, note);
              },
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => NoteDialog()
        ),
        backgroundColor: Color(0xfa59eae5),
        foregroundColor: Colors.white,
        child: Icon(Icons.add, size: 26,),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Note note) {
    return NoteCard(
      title: note.title,
      description: note.description,
      creationDate: note.creationDate,
      isFavourite: note.isFavourite,
      onFavouriteTap: () => context.read<NotesCubit>().toggleFavourite(note),
      onDeleteTap: () {
        _showDeleteConfirmationDialog(context, note);
      },
      onEditTap: () => showDialog(
        context: context,
        builder: (_) => NoteDialog(note: note,)
      ),
    );
  }
}