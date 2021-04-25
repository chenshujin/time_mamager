import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:timecop/blocs/login/login_event.dart';
import 'package:timecop/blocs/login/login_state.dart';
import 'package:timecop/components/toast_widget.dart';
import 'package:timecop/data_providers/data/data_provider.dart';
import 'package:timecop/data_providers/data/user_repo.dart';
import 'package:timecop/models/login/models.dart';
import 'package:timecop/models/person.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DataProvider data;// 加载数据
  LoginBloc(this.data);

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    } else if (event is Register) {
      // yield* _mapLoginSubmittedToState(event, state);
    }else if(event is GetUserSubmitted){
      yield* _mapUserSubmittedToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      print('username:${state.username.value}');
      print('password:${state.password.value}');
      UserProfile userProfile=await data.getUserProfilesByName(state.username.value);

      if(userProfile!=null){
        if(userProfile.password!=state.password.value){
          await bdsToast(msg: '登录失败，密码错误');
        }else {
          userRepo.updateMemData(userProfile);
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        }
      }else{
        await bdsToast(msg: '登录失败，用户名不存在');
      }
    }
  }

  Stream<LoginState> _mapUserSubmittedToState(
      GetUserSubmitted event,
      LoginState state,
      ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      print('username:${state.username.value}');
      print('password:${state.password.value}');
      UserProfile profile=await data.getUserProfilesByName(state.username.value);
      print('get user is $profile');
      // yield state.copyWith(status: FormzStatus.submissionSuccess);
    }
  }

  @override
  LoginState get initialState => LoginState();
}
