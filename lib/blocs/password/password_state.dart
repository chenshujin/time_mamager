import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:timecop/models/login/models.dart';

class PasswordState extends Equatable {
  const PasswordState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Password password;

  PasswordState copyWith({
    FormzStatus status,
    Username username,
    Password password,
  }) {
    return PasswordState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
