
import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class PasswordChanged extends PasswordEvent {
  const PasswordChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class ConfirmPasswordChanged extends PasswordEvent {
  const ConfirmPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordSubmitted extends PasswordEvent {
  const PasswordSubmitted();
}
