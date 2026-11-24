import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/data/settings_repository.dart';

class UserNameCubit extends Cubit<String> {
  UserNameCubit(this._repository) : super(_repository.getUserName());

  final SettingsRepository _repository;

  Future<void> saveName(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty || trimmed == state) return;

    emit(trimmed);
    await _repository.setUserName(trimmed);
  }
}