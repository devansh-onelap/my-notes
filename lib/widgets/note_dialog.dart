import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/cubits/notes_cubit.dart';
import 'package:my_notes/models/note.dart';

class NoteDialog extends StatefulWidget {
  final Note? note;

  const NoteDialog({super.key, this.note});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Title or description cannot be empty")),
      );
      return;
    }

    // add note else edit note
    if (widget.note == null) {
      await context.read<NotesCubit>().addNote(title, description);
    } else {
      await context.read<NotesCubit>().editNotes(widget.note!, title, description);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.note == null? "Create Note": "Edit note"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title"),
          SizedBox(height: 6,),
          TextField(
            controller: _titleController,
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
            controller: _descriptionController,
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
              FilledButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontWeight: FontWeight.bold)
                ),
                child: Text(widget.note == null? "Save" : "Update"),
              ),
              SizedBox(width: 6,),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              )
            ],
          )
        ],
      ),
    );
  }
}