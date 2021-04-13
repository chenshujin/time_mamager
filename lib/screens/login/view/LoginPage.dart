import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:timecop/blocs/login/login_bloc.dart';
import 'package:timecop/blocs/timers/bloc.dart';

import 'LoginForm.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(BlocProvider.of<TimersBloc>(context).data);
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
