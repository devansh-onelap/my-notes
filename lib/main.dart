import 'package:material_ui/material_ui.dart';
import 'note_card.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Notes",
      home: Scaffold(
        appBar: AppBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("My Notes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(height: 12,),
                Text("Your thoughts, all in one place", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                SizedBox(height: 12,)
              ],
            ),
            backgroundColor: Color(0xfa59eae5)
        ), body: ListView(
            padding: EdgeInsets.all(12),
            children: [
              NoteCard(
                  title: "Flutter LearningLearning Flutter and Building My First Notes Application",
                  description: "Learning Flutter fundamentals and goals testing example",
                  creationDate: "14 Nov 2026",),
              NoteCard(
                  title: "Daily Tasks",
                  description: "Complete today's goals",
                  creationDate: "13 Nov 2026",),
            ],
          ),
        ),
      ),
  );
}