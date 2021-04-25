import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timecop/data_providers/common.dart';

import '../l10n.dart';

enum AppTab { todos, stats, calendar, person }

extension AppTabExtension on AppTab {
  IconData get tabIconData => _transformIconData(this);
  Key get tabKey => _transformKey(this);

  // ignore: missing_return
  Key _transformKey(AppTab tab){
    switch (tab) {
      case AppTab.todos:
        return ArchSampleKeys.todoTab;
      case AppTab.stats:
        return ArchSampleKeys.statsTab;
      case AppTab.person:
        return ArchSampleKeys.personTab;
      case AppTab.calendar:
        return ArchSampleKeys.calendarTab;
    }
  }

  // ignore: missing_return
  IconData _transformIconData(AppTab tab) {
    switch (tab) {
      case AppTab.todos:
        return Icons.home;
      case AppTab.stats:
        return Icons.show_chart;
      case AppTab.person:
        return Icons.person;
      case AppTab.calendar:
        return Icons.timer;
    }
  }

}
