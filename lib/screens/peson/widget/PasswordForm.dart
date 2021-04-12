import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:timecop/blocs/password/password_bloc.dart';
import 'package:timecop/blocs/password/password_event.dart';
import 'package:timecop/blocs/password/password_state.dart';
import 'package:timecop/components/toast_widget.dart';

class PasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PassWordBloc,PasswordState>(listener: (context,state){
      if(state.status.isSubmissionSuccess){// 成功
        bdsToast(msg: 'success');
      }else{
        if(!state.username.valid) {
          bdsToast(msg: '请输入密码');
          return;
        }
        if(!state.password.valid){
          bdsToast(msg: '请再次输入密码');
          return;
        }
        if(state.username.value!=state.password.value){
          bdsToast(msg: '两次输入不一致');
          return;
        }
      }
    },child: Align(
      alignment: const Alignment(0, -1 / 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PasswordInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _ConfirmPasswordInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _ModifyPasswordButton(),
        ],
      ),
    ),);
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('passwordForm_passwordInput_textField'),
      onChanged: (password) =>
          BlocProvider.of<PassWordBloc>(context).add(PasswordChanged(password)),
      decoration: InputDecoration(
        labelText: 'password',
      ),
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('passwordForm_confirmInput_textField'),
      obscureText: true,
      onChanged: (confirmPassword)=>BlocProvider.of<PassWordBloc>(context).add(ConfirmPasswordChanged(confirmPassword)),
      decoration: InputDecoration(
        labelText: 'confirm password',
      ),
    );
  }
}

class _ModifyPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      key: const Key('passwordForm_continue_raisedButton'),
      child: const Text('sure'),
      onPressed: (){
        BlocProvider.of<PassWordBloc>(context).add(const PasswordSubmitted());
      },
    );
  }
}
