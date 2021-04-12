import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timecop/blocs/tab/tab.dart';
import 'package:timecop/components/tab_selector.dart';
import 'package:timecop/extensions/screen_utils.dart';
import 'package:timecop/models/app_tab.dart';
import 'package:timecop/screens/dashboard/DashboardScreen.dart';
import 'package:timecop/screens/peson/Mypage.dart';
import 'package:timecop/screens/reports/ReportsScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 667));
    return WillPopScope(child: Material(
      child: BlocBuilder<TabBloc, AppTab>(
        builder: (context, activeTab) {
          return Stack(
            children: [
              Positioned(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: _bodyContent(activeTab)),
                      TabSelector(
                        activeTab: activeTab,
                        onTabSelected: (tab) =>
                            BlocProvider.of<TabBloc>(context)
                                .add(TabUpdated(tab)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ), onWillPop: () {
      exit(0);
    });
  }

  // ignore: missing_return
  Widget _bodyContent(AppTab tab) {
    switch(tab){
      case AppTab.todos:
        return DashboardScreen();
      case AppTab.stats:
        return ReportsScreen();
      case AppTab.person:
        return MyPage();
    }
  }
}
