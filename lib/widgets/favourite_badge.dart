import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_notes/controllers/notes_controller.dart';

class FavouriteBadge extends StatelessWidget {
  FavouriteBadge({super.key});

  final controller = Get.find<NotesController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.favorite, size: 18,),
        SizedBox(width: 6,),
        Obx(() {
          return Text("${controller.favouriteCount}", style: TextStyle(fontSize: 18),);
        })
      ],
    );
  }
}