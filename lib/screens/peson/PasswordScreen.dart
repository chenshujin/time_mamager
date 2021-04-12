import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timecop/blocs/password/password_bloc.dart';
import 'package:timecop/screens/peson/widget/PasswordForm.dart';

class PasswordPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Password')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return PassWordBloc();
          },
          child: PasswordForm(),
        ),
      ),
    );
  }
}