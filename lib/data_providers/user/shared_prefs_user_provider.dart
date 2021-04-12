import 'package:shared_preferences/shared_preferences.dart';
import 'package:timecop/data_providers/user/users_provider.dart';

class SharedPrefsUserProvider extends UserProvider {
  final SharedPreferences _prefs;
  SharedPrefsUserProvider(this._prefs) : assert(_prefs != null);
  static Future<SharedPrefsUserProvider> load() async {
    return SharedPrefsUserProvider(await SharedPreferences.getInstance());
  }

  @override
  String getPassword() {
    return _prefs.getString("password");
  }

  @override
  void setPassword(String password) {
    _prefs.setString("password", password);
  }

  @override
  String getUserName() {
    return _prefs.getString("username");
  }

  @override
  void setUserName(String username) {
    _prefs.setString("username", username);
  }

  @override
  bool getBool() {
    return _prefs.getBool('isLogin');
  }

  @override
  void setBool(bool value) {
    _prefs.setBool("isLogin", value);
  }

}
