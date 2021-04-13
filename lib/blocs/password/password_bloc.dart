import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:timecop/blocs/password/password_event.dart';
import 'package:timecop/blocs/password/password_state.dart';
import 'package:timecop/models/login/models.dart';

class PassWordBloc extends Bloc<PasswordEvent, PasswordState> {
  /*LoginBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;*/

  @override
  Stream<PasswordState> mapEventToState(
    PasswordEvent event,
  ) async* {
    if (event is PasswordChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is ConfirmPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is PasswordSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  PasswordState _mapUsernameChangedToState(
    PasswordChanged event,
    PasswordState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  PasswordState _mapPasswordChangedToState(
    ConfirmPasswordChanged event,
    PasswordState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<PasswordState> _mapLoginSubmittedToState(
    PasswordSubmitted event,
    PasswordState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      print('username:${state.username.value} \n');
      print('password:${state.password.value} \n');
      if (state.username.value == state.password.value) {
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } else {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    } else {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }

  @override
  PasswordState get initialState => PasswordState();
}
