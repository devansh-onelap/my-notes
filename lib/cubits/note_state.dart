import 'package:equatable/equatable.dart';
import 'package:my_notes/models/note.dart';

enum NoteStatus {
  initial,
  loading,
  success,
  failure
}

class NoteState extends Equatable {

  const NoteState({
    this.notes = const [],
    this.status = NoteStatus.initial,
    this.errorMessage
  });

  final List<Note> notes;
  final String? errorMessage;
  final NoteStatus status;

  NoteState copyWith({List<Note>? notes, String? errorMessage, NoteStatus? status}) {
    return NoteState(
      notes: notes ?? this.notes,
      status: status ?? this.status,
      errorMessage: errorMessage
    );
  }

  List<Note> get favouriteNotes => notes.where((n) => n.isFavourite).toList();
  int get favouriteCount => favouriteNotes.length;

  @override
  List<Object?> get props => [notes, errorMessage, status];
}