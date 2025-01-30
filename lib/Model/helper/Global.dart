import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static SharedPreferences? preferences;
  static void init() async {
    preferences = await SharedPreferences.getInstance();
  }
}
