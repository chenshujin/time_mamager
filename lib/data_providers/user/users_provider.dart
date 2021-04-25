

import 'package:timecop/models/person.dart';

abstract class UserProvider {
  bool getBool();
  void setBool(bool value);

  String getUserName();
  void setUserName(String username);

  String getPassword();
  void setPassword(String password);

  void  setUserProfile(UserProfile userProfile);

  UserProfile getUserProfile(){
    return null;
  }
}
