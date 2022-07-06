import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _prefs;

  static String _phrase = '';
  String _username = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get phrase {
    return _prefs?.getString('phrase') ?? _phrase;
  }

  static set phrase(String phrase) {
    _phrase = phrase;
    _prefs?.setString('phrase', phrase);
  }

  String get username {
    return _prefs?.getString('username') ?? _username;
  }

  set username(String username) {
    _username = username;
    _prefs?.setString('username', username);
  }
}
