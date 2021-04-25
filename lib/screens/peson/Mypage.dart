import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timecop/blocs/timers/bloc.dart';
import 'package:timecop/components/basic.dart';
import 'package:timecop/data_providers/data/user_repo.dart';
import 'package:timecop/extensions/common_extension.dart';
import 'package:timecop/extensions/screen_utils.dart';
import 'package:timecop/extensions/text_widgets.dart';
import 'package:timecop/l10n.dart';
import 'package:timecop/screens/login/view/LoginPage.dart';
import 'package:timecop/screens/peson/PasswordScreen.dart';
import 'package:timecop/screens/peson/PersonInfoPage.dart';
import 'package:timecop/screens/projects/ProjectsScreen.dart';
import 'package:timecop/screens/settings/SettingsScreen.dart';

import 'AboutScreen.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _helpItems = [
    _ItemProduct('项目', FontAwesomeIcons.layerGroup, 0),
    _ItemProduct('修改密码', FontAwesomeIcons.unlock, 1),
    _ItemProduct('设置', FontAwesomeIcons.slidersH, 2),
    _ItemProduct('时间管理', FontAwesomeIcons.hourglass, 3),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _content()),
        SimpleText(
          '退出登录',
          margin: EdgeInsets.only(bottom: 20.dp),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 8.dp, vertical: 5.dp),
          onClick: () {
            BlocProvider.of<TimersBloc>(context).userProvider.setUserName(null);
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute<ProjectsScreen>(
              builder: (BuildContext _context) => LoginPage(),
            ));
          },
        )
      ],
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _header(),
          newHelp(0),
          newHelp(1),
          newHelp(2),
          newHelp(3),
        ],
      ),
    );
  }

  Widget newHelp(int index) {
    var item = _helpItems[index];
    return GestureDetector(
      child: Container(
        height: 55.dp,
        padding: EdgeInsets.only(left: 20.dp),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5.dp, color: Colors.blueGrey))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                item.iconImage,
                size: 20.dp,
              ),
              Space.h(15.dp),
              Expanded(child: Text(item.itemName)),
              Icon(
                FontAwesomeIcons.angleRight,
                size: 15.dp,
              ),
              Space.h(20.dp),
            ],
          ),
        ),
      ),
      onTap: () {
        switch (index) {
          case 0: //项目
            Navigator.of(context).push(MaterialPageRoute<ProjectsScreen>(
              builder: (BuildContext _context) => ProjectsScreen(),
            ));
            break;
          case 1: // 修改密码
            Navigator.of(context).push(MaterialPageRoute<ProjectsScreen>(
              builder: (BuildContext _context) => PasswordPage(),
            ));
            break;

          case 2:
            Navigator.of(context).push(MaterialPageRoute<SettingsScreen>(
              builder: (BuildContext _context) => SettingsScreen(),
            ));
            // 设置
            break;
          case 3:
            Navigator.of(context).push(MaterialPageRoute<AboutScreen>(
              builder: (BuildContext _context) => AboutScreen(),
            ));
            //关于
            break;
        }
      },
    );
  }

  Widget _header() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<ProjectsScreen>(
          builder: (BuildContext _context) => PersonInfoPage(),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 30.dp),
        child: Stack(
          children: [
            Positioned(
              child: Column(
                children: [
                  SafeArea(
                    bottom: false,
                    child: Container(),
                  ),
                  Stack(
                    children: [
                      Column(
                        children: [
                          Space.v(47.dp),
                          _headView(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _headView() {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Space.h(16.dp),
          _buildHeaderImage(),
          Space.h(10.5.dp),
          Expanded(
            child: true
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '昵称 ${userRepo.userProfile.name}',
                          style: TextStyle(
                            fontSize: 18.dp,
                          ),
                        ),
                        Space.h(4.dp),
                        Text(
                          ('手机号：13333333333'),
                          style:
                              TextStyle(fontSize: 14.dp),
                        ),
                      ],
                    ),
                  )
                : Text(
                    '登录/注册',
                    style: TextStyle(fontSize: 20.dp, color: Colors.white),
                  ),
            flex: 1,
          ),
          Space.h(16.dp),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Stack(
      children: [
        Container(
          width: 90.dp,
          height: 90.dp,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(45.dp),
          ),
          child: Center(
            child: Container(
              width: 89.dp,
              height: 89.dp,
              decoration: BoxDecoration(
                color: Color(0xffE3C591),
                borderRadius: BorderRadius.circular(45.dp),
              ),
              child: Center(
                child: _buildAvatar(
                    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1505540527,346927184&fm=26&gp=0.jpg'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(String url) {
    Widget image;
    if (url.isEmpty) {
      image = ExtendedImage.network(
        url,
        width: 80.dp,
        height: 80.dp,
        fit: BoxFit.cover,
      );
    } else {
      image = Image.network(
        url,
        width: 80.dp,
        height: 80.dp,
        fit: BoxFit.cover,
      );
    }
    return Container(
      width: 80.dp,
      height: 80.dp,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.dp),
        child: image,
      ),
    );
  }
}

class _ItemProduct {
  final String itemName;
  final IconData iconImage;
  final int index;

  _ItemProduct(this.itemName, this.iconImage, this.index);
}
