import 'package:shared_preferences/shared_preferences.dart';

class Sharedpref {
  static Future<void> setbool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool> getbool(String key, {bool defaultvalue = true}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultvalue;
  }

  static Future<bool> removekey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<bool> clearall() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
