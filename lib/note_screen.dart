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
      title: "Flutter Learning",
      description: "Learning Flutter fundamentals",
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
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter title here",
                ),
              ),
              SizedBox(height: 24),
              Text("Description"),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Enter description here"
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
                    child: Text("Save"),
                  ),
                  SizedBox(width: 6,),
                  ElevatedButton(
                    onPressed: () {
                      _cancelNote();
                    },
                    child: Text("cancel"),
                  )
                ],
              )
            ],
          )
        );
      }
    );
  }

  void _saveNote() {
    final String title = titleController.text.trim();
    final String description = descriptionController.text.trim();
    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Both title and description are required"),
        )
      );
    } else {
      Note newNote = Note(
          title: title,
          description: description,
          creationDate: _getCurrentDate()
      );
      setState(() {
        notes.add(newNote);
      });
    }
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
    final now = DateTime.now();

    return "${now.day} ${_getMonthName(now.month)} ${now.year}";
  }

  String _getMonthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr",
      "May", "Jun", "Jul", "Aug",
      "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
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
    return Scaffold(
        appBar: AppBar(
            title: Container(
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
                        width: 36,
                        height: 36,
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
        body: ListView.builder(
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
              }
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showCreateNoteDialog();
          },
          backgroundColor: Color(0xfa59eae5),
          child: Icon(Icons.add),
        ),
    );
  }
}