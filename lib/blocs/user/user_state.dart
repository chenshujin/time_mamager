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

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:timecop/data_providers/user/shared_prefs_user_provider.dart';
import 'package:timecop/models/person.dart';

class UsersState extends Equatable {
  final UserProfile profile;
  UsersState(this.profile);

  static UsersState initial() {
    return UsersState(null);
  }



  @override
  List<Object> get props => [
    profile
  ];
}
