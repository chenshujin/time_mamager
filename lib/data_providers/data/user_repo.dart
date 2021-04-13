import 'package:timecop/models/person.dart';

final Person ps = Person('头像', '李费费', 'LiFeiFei', '10/31', 'code');

final UserAccountProfile userAccountProfile=UserAccountProfile(10008, 'Vivian', '123456');

final _UserRepo userRepo=_UserRepo();

class _UserRepo {
  UserProfile userProfile;

  void updateMemData(UserProfile newData) {
    userProfile = newData;
  }

  Future<bool> authenticationRepository(String name,String password){

  }
}