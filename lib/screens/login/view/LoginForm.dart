
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:timecop/blocs/login/login_bloc.dart';
import 'package:timecop/blocs/login/login_event.dart';
import 'package:timecop/blocs/login/login_state.dart';
import 'package:timecop/blocs/projects/bloc.dart';
import 'package:timecop/blocs/timers/bloc.dart';
import 'package:timecop/blocs/user/bloc.dart';
import 'package:timecop/components/basic.dart';
import 'package:timecop/components/toast_widget.dart';
import 'package:timecop/data_providers/data/user_repo.dart';
import 'package:timecop/screens/HomeScreen.dart';
import 'package:timecop/screens/login/view/RegisterPage.dart';
import 'package:timecop/screens/projects/ProjectsScreen.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc,LoginState>(listener: (context,state) {
      if(state.status.isSubmissionSuccess){// 成功
        // 跳到进入主页页面
        BlocProvider.of<UserBloc>(context).add(UserLogin(userRepo.userProfile));
        BlocProvider.of<TimersBloc>(context).add(LoadTimers());
        BlocProvider.of<ProjectsBloc>(context).add(LoadProjects());

        Navigator.of(context).push(MaterialPageRoute<ProjectsScreen>(
          builder: (BuildContext _context) => HomeScreen(),
        ));
      }else{
        bdsToast(msg: state.status.toString());
      }
    },child: Align(
      alignment: const Alignment(0, -1 / 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _UsernameInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _PasswordInput(),
          const Padding(padding: EdgeInsets.all(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LoginButton(),
              Space.h(25),
              _RegisterButton(),
            ],
          ),
          // _UserButton(),
        ],
      ),
    ),);
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (username) =>
          BlocProvider.of<LoginBloc>(context).add(LoginUsernameChanged(username)),
      decoration: InputDecoration(
        labelText: 'username',
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      obscureText: true,
      onChanged: (password)=>BlocProvider.of<LoginBloc>(context).add(LoginPasswordChanged(password)),
      decoration: InputDecoration(
        labelText: 'password',
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      key: const Key('loginForm_continue_raisedButton'),
      child: const Text('Login'),
      onPressed: (){
        BlocProvider.of<LoginBloc>(context).add(const LoginSubmitted());
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      key: const Key('loginForm_register_raisedButton'),
      child: const Text('Register'),
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute<ProjectsScreen>(
          builder: (BuildContext _context) => RegisterPage(),
        ));
      },
    );
  }
}

class _UserButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      key: const Key('loginForm_get_raisedButton'),
      child: const Text('Get user'),
      onPressed: (){
        BlocProvider.of<LoginBloc>(context).add(const GetUserSubmitted());
      },
    );
  }
}
