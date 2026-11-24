import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_notes/controllers/notes_controller.dart';
import 'package:my_notes/cubits/note_state.dart';
import 'package:my_notes/cubits/notes_cubit.dart';

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
        BlocBuilder<NotesCubit, NoteState>(
          buildWhen: (previous, current) => previous.favouriteCount != current.favouriteCount,
          builder: (context, state) {
            return Text("${state.favouriteCount}", style: TextStyle(fontSize: 18),);
          },
        )
      ],
    );
  }
}