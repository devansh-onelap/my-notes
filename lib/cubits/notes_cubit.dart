import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/cubits/note_state.dart';
import 'package:my_notes/data/notes_repository.dart';
import 'package:my_notes/models/note.dart';

class NotesCubit extends Cubit<NoteState> {
  NotesCubit(this._repository): super(const NoteState());

  final NotesRepository _repository;

  Future<void> addNote(String title, String description) async {
    final note = Note(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      creationDate: _getCurrentDate(),
      title: title,
      description: description,
    );

    try {
      await _repository.insertNote(note);
      emit(state.copyWith(status: NoteStatus.success, notes: [...state.notes, note]));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.failure,
          errorMessage: "Could not save note: $e"
      ));
      emit(state.copyWith(status: NoteStatus.success));
    }
  }

  String _getCurrentDate() {
    return DateFormat("d MMM yyyy").format(DateTime.now());
  }

  Future<void> editNotes(Note note, String title, String description) async {
    final updatedNote = note.copyWith(title: title, description: description);

    try {
      await _repository.updateNote(updatedNote);
      emit(state.copyWith(
          status: NoteStatus.success,
          notes: state.notes.map((n) => n.id == updatedNote.id? updatedNote : n).toList()
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NoteStatus.failure,
        errorMessage: "Could not update note: $e"
      ));
      emit(state.copyWith(status: NoteStatus.success));
    }
  }

  Future<void> toggleFavourite(Note note) async {
    Note updatedNote = note.copyWith(isFavourite: !note.isFavourite);
    try {
      await _repository.updateNote(updatedNote);
      emit(state.copyWith(
          status: NoteStatus.success,
          notes: state.notes.map((n) => n.id == updatedNote.id? updatedNote : n).toList()
      ));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.failure,
          errorMessage: "Could not update note: $e"
      ));
      emit(state.copyWith(status: NoteStatus.success));
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _repository.deleteNote(id);
      emit(state.copyWith(
          status: NoteStatus.success,
          notes: state.notes.where((n) => n.id != id).toList()
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NoteStatus.failure,
        errorMessage: "Could not delete note: $e"
      ));
      emit(state.copyWith(status: NoteStatus.success));
    }
  }

  Future<void> loadNotes() async {
    emit(state.copyWith(status: NoteStatus.loading));
    try {
      final allNotes = await _repository.getAllNotes();
      emit(state.copyWith(notes: allNotes, status: NoteStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.failure,
          errorMessage: "Could not load notes: $e"
      ));
    }
  }

  @override
  void onChange(Change<NoteState> change) {
    super.onChange(change);
    print("ST: ${change.currentState.status.name} -> ${change.nextState.status.name}");
  }
}