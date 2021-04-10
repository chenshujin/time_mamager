import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timecop/data_providers/common.dart';
import 'package:timecop/l10n.dart';
import 'package:timecop/models/app_tab.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: ArchSampleKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab.tabIconData,
            key: tab.tabKey
          ),
          label: _transformLabel(context,tab)
        );
      }).toList(),
    );
  }

  String _transformLabel(BuildContext context,AppTab tab) {
    switch(tab){
      case AppTab.todos:
        return L10N.of(context).todos;
      case AppTab.stats:
        return L10N.of(context).stats;
      case AppTab.person:
        return L10N.of(context).person;
    }
  }
}
