// Copyright 2020 Kenton Hamaluik
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:timecop/blocs/projects/projects_event.dart';
import 'package:timecop/blocs/timers/timers_event.dart';
import 'package:timecop/data_providers/data/data_provider.dart';
import 'package:timecop/data_providers/data/database_provider.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:timecop/data_providers/settings/settings_provider.dart';
import 'package:timecop/data_providers/user/shared_prefs_user_provider.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UsersState> {
  final SharedPrefsUserProvider userProvider;
  UserBloc(this.userProvider);// 导入

  @override
  UsersState get initialState => UsersState.initial();

  @override
  Stream<UsersState> mapEventToState(
    UserEvent event,
  ) async* {
    if(event is UserLogin){
      userProvider.setUserProfile(event.profile);
    }
  }
}
