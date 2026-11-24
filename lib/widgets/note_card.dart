import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String description;
  final String creationDate;
  final bool isFavourite;
  final VoidCallback onFavouriteTap;
  final VoidCallback onDeleteTap;
  final VoidCallback onEditTap;

  const NoteCard({
    super.key,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.isFavourite,
    required this.onFavouriteTap,
    required this.onDeleteTap,
    required this.onEditTap
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.note_alt_outlined),
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              onPressed: onFavouriteTap,
              icon: isFavourite? Icon(Icons.favorite, color: Colors.red) :
              Icon(Icons.favorite_border, color: Colors.grey),
              iconSize: 24,
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today, size: 14,),
                        SizedBox(width: 6,),
                        Text(creationDate, style: TextStyle(fontSize: 12),)
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: onEditTap,
                          icon: Icon(Icons.edit, size: 18,),
                        ),
                        IconButton(
                          onPressed: onDeleteTap,
                          icon: Icon(Icons.delete, size: 18,),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }
}