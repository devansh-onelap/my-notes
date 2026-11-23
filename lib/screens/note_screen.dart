import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/controllers/notes_controller.dart';
import 'package:my_notes/models/note.dart';
import 'package:my_notes/widgets/favourite_badge.dart';
import 'package:my_notes/widgets/note_card.dart';

class NoteScreen extends GetView<NotesController> {
  NoteScreen({super.key});

  Future<void> _saveNote(BuildContext context) async {
    final error = await controller.addNote();
    if (!context.mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }
    Navigator.pop(context);
  }

  Future<void> _updateNote(BuildContext context, {required Note note}) async {
    final error = await controller.editNote(note.id);
    if (!context.mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }
    Navigator.pop(context);
  }

  void _deleteNote(BuildContext context, Note note) {
    controller.deleteNote(note.id);
    Navigator.pop(context);
  }

  void _cancelNote(BuildContext context) {
    Navigator.pop(context);
    controller.clearForm();
  }

  void _showNoteDialog(BuildContext context, {Note? note}) {
    // for input fields in case of edit.
    if (note != null) {
      controller.loadNoteForEditing(note.id);
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(note == null? "Create Note": "Edit note"),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title"),
                SizedBox(height: 6,),
                TextField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    hintText: "Enter title here",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text("Description"),
                SizedBox(height: 6,),
                TextField(
                  controller: controller.descriptionController,
                  decoration: InputDecoration(
                      hintText: "Enter description here",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        note == null? _saveNote(context) : _updateNote(context, note: note);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xfa59eae5),
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      child: Text(note == null? "Save" : "Update"),
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
            ),
        );
      }
    ).then((_) => controller.clearForm());
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
                      _deleteNote(context, note);
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
      body: Obx(() {
        print("obx body build");

        // spinner while the first load happens
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // friendly message when there are no notes
        if (controller.notes.isEmpty) {
          return const Center(child: Text("No notes yet. Tap + to create one."));
        }

        return screenWidth < 600?
        ListView.builder(
          itemCount: controller.notes.length,
          padding: EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final note = controller.notes[index];
            return _buildCard(context, note);
          },
        ) :
        GridView.builder(
          itemCount: controller.notes.length,
          padding: EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 160,
          ),
          itemBuilder: (context, index) {
            final note = controller.notes[index];

            return _buildCard(context, note);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNoteDialog(context);
        },
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
      onFavouriteTap: () {
        controller.toggleFavourite(note.id);
      },
      onDeleteTap: () {
        _showDeleteConfirmationDialog(context, note);
      },
      onEditTap: () {
        _showNoteDialog(context, note: note);
      },
    );
  }
}