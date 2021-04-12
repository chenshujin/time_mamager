import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timecop/blocs/login/login_bloc.dart';
import 'package:timecop/blocs/login/login_event.dart';
import 'package:timecop/blocs/login/login_state.dart';
import 'package:timecop/components/toast_widget.dart';
import 'package:timecop/screens/HomeScreen.dart';
import 'package:timecop/screens/projects/ProjectsScreen.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc,LoginState>(listener: (context,state) {
      if(state.status.isSubmissionSuccess){// 成功
        // 跳到进入主页页面
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
          _LoginButton(),
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
