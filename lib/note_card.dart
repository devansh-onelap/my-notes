import 'package:material_ui/material_ui.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String description;
  final String creationDate;

  const NoteCard({super.key, required this.title, required this.description, required this.creationDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded (
                child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Icon(Icons.favorite, color: Colors.red, size: 24,)
            ],
          ),
          SizedBox(height: 12,),
          Text(description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
          SizedBox(height: 12,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_today, size: 14,),
              SizedBox(width: 6,),
              Text(creationDate, style: TextStyle(fontSize: 12),)
            ],
          )
        ],
      ),
    );
  }
}