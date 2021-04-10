import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:timecop/models/app_tab.dart';

import 'tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }

  @override
  AppTab get initialState => AppTab.todos;
}
