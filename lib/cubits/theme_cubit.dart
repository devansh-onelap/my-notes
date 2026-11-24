import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/settings_repository.dart';

class ThemeCubit extends Cubit<bool> {
  final SettingsRepository _repo;

  ThemeCubit(this._repo) : super(_repo.isDarkMode());

  Future<void> toggleTheme() async {
    final newValue = !state;
    emit(newValue);
    await _repo.setDarkMode(newValue);
  }
}