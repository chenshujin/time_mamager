
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:timecop/blocs/login/login_bloc.dart';
import 'package:timecop/blocs/login/login_event.dart';
import 'package:timecop/blocs/login/login_state.dart';
import 'package:timecop/blocs/register/register_bloc.dart';
import 'package:timecop/blocs/register/register_event.dart';
import 'package:timecop/blocs/register/register_state.dart';
import 'package:timecop/blocs/timers/bloc.dart';
import 'package:timecop/blocs/user/bloc.dart';
import 'package:timecop/components/toast_widget.dart';
import 'package:timecop/data_providers/data/user_repo.dart';
import 'package:timecop/screens/HomeScreen.dart';
import 'package:timecop/screens/login/view/LoginPage.dart';
import 'package:timecop/screens/projects/ProjectsScreen.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc,RegisterState>(listener: (context,state) {
      if(state.status.isSubmissionSuccess){// 成功
        // 跳到进入主页页面
        BlocProvider.of<UserBloc>(context).add(UserLogin(userRepo.userProfile));
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
          _RegisterButton(),
        ],
      ),
    ),);
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('registerForm_usernameInput_textField'),
      onChanged: (username) =>
          BlocProvider.of<RegisterBloc>(context).add(RegisterUsernameChanged(username)),
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
      key: const Key('registerForm_passwordInput_textField'),
      obscureText: true,
      onChanged: (password)=>BlocProvider.of<RegisterBloc>(context).add(RegisterPasswordChanged(password)),
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
      key: const Key('registerForm_continue_raisedButton'),
      child: const Text('Login'),
      onPressed: (){
        BlocProvider.of<RegisterBloc>(context).add(const RegisterSubmitted());
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      key: const Key('registerForm_register_raisedButton'),
      child: const Text('Register'),
      onPressed: (){
        BlocProvider.of<RegisterBloc>(context).add(const RegisterSubmitted());
        // Navigator.of(context).push(MaterialPageRoute<ProjectsScreen>(
        //   builder: (BuildContext _context) => LoginPage(),
        // ));
      },
    );
  }
}
