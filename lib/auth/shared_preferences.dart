import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static void Save_Infor(String password, String email, bool remember) async {
    final share_auth = await SharedPreferences.getInstance();
    await share_auth.setString("password", password);
    await share_auth.setString("email", email);
    await share_auth.setBool("remember", remember);
  }

  static Future<Map<dynamic, dynamic>> Get_Infor() async {
    final share_auth = await SharedPreferences.getInstance();
    final password = await share_auth.getString("password");
    final email = await share_auth.getString("email");
    final remember = await share_auth.getBool("remember");
    return {"email": email, "password": password, "remember": remember};
  }

  static void SaveTheme(String switchTheme) async {
    final themesave = await SharedPreferences.getInstance();
    await themesave.setString("switch", switchTheme);
  }

  static Future<String> GetTheme() async {
    final themesave = await SharedPreferences.getInstance();
    final switchTheme = await themesave.getString("switch");
    return switchTheme ?? "LightTheme";
  }
}
