import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/cubits/note_state.dart';
import 'package:my_notes/cubits/notes_cubit.dart';

class FavouriteBadge extends StatelessWidget {
  FavouriteBadge({super.key});

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