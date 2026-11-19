import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_notes/note.dart';
import 'package:my_notes/note_card.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  List<Note> notes = [
    Note(
      title: "Flutter Learning test anotherdjfkdsk fldsajkf jldsjf adsjlkfdjkla test",
      description: "Learning Flutter fundamentals dfjkajkdfakl df dfa dfadfajkajkdfakl tdfjkajkdfakl test",
      creationDate: "14 Nov 2026",
      isFavourite: true
    ),
    Note(
      title: "Daily Tasks",
      description: "Complete today's goals",
      creationDate: "13 Nov 2026",
    ),
  ];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void onFavouriteTap(Note note) {
    setState(() {
      note.isFavourite = !note.isFavourite;
    });
  }

  void _showCreateNoteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title"),
              SizedBox(height: 6,),
              TextField(
                controller: titleController,
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
                controller: descriptionController,
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
                      _saveNote();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xfa59eae5),
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    child: Text("Save"),
                  ),
                  SizedBox(width: 6,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
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

  void _showDeleteConfirmationDialog(Note note) {
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
                      _deleteNote(note);
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
                    onPressed: _cancelNote,
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

  void _deleteNote(Note note) {
    setState(() {
          notes.remove(note);
    });
    Navigator.pop(context);
  }

  void _saveNote() {
    final String title = titleController.text.trim();
    final String description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Both title and description are required")),
      );
      return;
    }

    setState(() {
      notes.add(Note(
        title: title,
        description: description,
        creationDate: _getCurrentDate(),
      ));
    });

    titleController.clear();
    descriptionController.clear();
    Navigator.pop(context);
  }

  void _cancelNote() {
    titleController.clear();
    descriptionController.clear();
    Navigator.pop(context);
  }

  String _getCurrentDate() {
    return DateFormat("d MMM yyyy").format(DateTime.now());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar:
        AppBar(
            title: SizedBox(
              height: 74,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 3),
                  Text("Your thoughts, all in one place", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            backgroundColor: Color(0xfa59eae5)
        ),
        body: screenWidth < 600?
        ListView.builder(
          itemCount: notes.length,
          padding: EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final note = notes[index];
            return NoteCard(
              title: note.title,
              description: note.description,
              creationDate: note.creationDate,
              isFavourite: note.isFavourite,
              onFavouriteTap: () {
                onFavouriteTap(note);
              },
              onDeleteTap: () {
                _showDeleteConfirmationDialog(note);
              },
            );
          },
        ) :
      GridView.builder(
        itemCount: notes.length,
        padding: EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 160,
        ),
        itemBuilder: (context, index) {
          final note = notes[index];

          return NoteCard(
            title: note.title,
            description: note.description,
            creationDate: note.creationDate,
            isFavourite: note.isFavourite,
            onFavouriteTap: () {
              onFavouriteTap(note);
            },
            onDeleteTap: () {
              _showDeleteConfirmationDialog(note);
            },
          );
        },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showCreateNoteDialog();
          },
          backgroundColor: Color(0xfa59eae5),
          foregroundColor: Colors.white,
          child: Icon(Icons.add, size: 26,),
        ),
    );
  }
}