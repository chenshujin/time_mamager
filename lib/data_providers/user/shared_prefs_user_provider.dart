import 'package:shared_preferences/shared_preferences.dart';
import 'package:timecop/data_providers/user/users_provider.dart';
import 'package:timecop/models/person.dart';

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

  @override
  void setUserProfile(UserProfile userProfile) {
    _prefs.setInt('id', userProfile.id);
    _prefs.setString('avatar', userProfile.avatar ?? '');
    _prefs.setString('phone', userProfile.phone ?? '');
    _prefs.setString('birthday', userProfile.birthday ?? '');
    _prefs.setString('hobby', userProfile.hobby ?? '');
    _prefs.setString('nick', userProfile.nick);
    setUserName(userProfile.name);
    setPassword(userProfile.password);
  }

  @override
  UserProfile getUserProfile() {
    int id = _prefs.getInt('id');
    String avatar = _prefs.getString('avatar');
    String phone = _prefs.getString('phone');
    String birthday = _prefs.getString('birthday');
    String hobby = _prefs.getString('hobby');
    String nick = _prefs.getString('nick');
    String userName = getUserName();
    String password = getPassword();
    return UserProfile(id, userName, password, avatar, phone, birthday, nick, hobby);
  }
}
