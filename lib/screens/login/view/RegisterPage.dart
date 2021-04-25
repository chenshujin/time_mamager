import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:timecop/blocs/login/login_bloc.dart';
import 'package:timecop/blocs/register/register_bloc.dart';
import 'package:timecop/blocs/timers/bloc.dart';
import 'package:timecop/screens/login/view/RegisterForm.dart';

import 'LoginForm.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return RegisterBloc(BlocProvider.of<TimersBloc>(context).data);
          },
          child: RegisterForm(),
        ),
      ),
    );
  }
}
