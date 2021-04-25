import 'package:equatable/equatable.dart';

class Person {
  final String avator;
  final String nickName;
  final String userName;
  final String birthDay;
  final String hobby;

  Person(this.avator, this.nickName, this.userName, this.birthDay, this.hobby);
}

class UserAccountProfile {
  final int userAccountId;
  final String userName;
  final String password;

  UserAccountProfile(this.userAccountId, this.userName, this.password);
}

// dataBase
class UserProfile extends Equatable {
  final int id;
  final String name;
  final String password;
  final String avatar;
  final String phone;
  final String birthday;
  final String nick;
  final String hobby;

  UserProfile(this.id, this.name, this.password, this.avatar, this.phone,
      this.birthday, this.nick, this.hobby);

  @override
  String toString() {
    return 'id = $id  name = $name password= $password avatar = $avatar phone = $phone birthday = $birthday nick = $nick hobby = $hobby \n';
  }

  @override
  List<Object> get props =>
      [id, name, password, avatar, phone, birthday, nick, hobby];
}
