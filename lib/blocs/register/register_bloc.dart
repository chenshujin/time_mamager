import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:timecop/blocs/register/register_event.dart';
import 'package:timecop/blocs/register/register_state.dart';
import 'package:timecop/data_providers/data/data_provider.dart';
import 'package:timecop/data_providers/data/user_repo.dart';
import 'package:timecop/models/login/models.dart';
import 'package:timecop/models/person.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final DataProvider data; // 加载数据
  RegisterBloc(this.data);

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is RegisterPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is RegisterSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  RegisterState _mapUsernameChangedToState(
    RegisterUsernameChanged event,
    RegisterState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  RegisterState _mapPasswordChangedToState(
    RegisterPasswordChanged event,
    RegisterState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<RegisterState> _mapLoginSubmittedToState(
    RegisterSubmitted event,
    RegisterState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      print('username:${state.username.value}');
      print('password:${state.password.value}');
      UserProfile userProfile = await data.createUserProfile(
          name: state.username.value, password: state.password.value);
      if(userProfile!=null) {
        userRepo.updateMemData(userProfile);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }
    }
  }

  @override
  RegisterState get initialState => RegisterState();
}
