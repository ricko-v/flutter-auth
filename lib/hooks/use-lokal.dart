import 'package:shared_preferences/shared_preferences.dart';

Future saveLocal(String key, String data) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, data);
}

Future getLocal(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future removeLocal(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}