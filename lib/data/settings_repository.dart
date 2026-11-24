import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  SettingsRepository(this._prefs);
  final SharedPreferences _prefs;

  static const _darkModeKey = 'dark_mode';
  static const _userNameKey = 'user_name';

  bool isDarkMode() => _prefs.getBool(_darkModeKey) ?? false;
  Future<void> setDarkMode(bool value) => _prefs.setBool(_darkModeKey, value);

  String getUserName() => _prefs.getString(_userNameKey) ?? '';
  Future<void> setUserName(String name) => _prefs.setString(_userNameKey, name);
}