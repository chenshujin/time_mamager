import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timecop/extensions/screen_utils.dart';

// 填充两端
class FillInfoDouble extends StatelessWidget {
  final FillInfo fillInfo;
  final VoidCallback callback;

  FillInfoDouble(this.fillInfo,this.callback);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>callback(),
      child: Container(
        height: 50.dp,
        padding: EdgeInsets.symmetric(horizontal: 15.dp),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.5.dp, color: Colors.blueGrey))),
        child: Row(
          children: [
            Expanded(child: Text(fillInfo.hint)),
            Text(fillInfo.info,),
            Icon(
              FontAwesomeIcons.angleRight,
              size: 15.dp,
            ),
          ],
        ),
      ),
    );
  }
}


class FillInfo {
  final String hint;
  final String info;

  FillInfo(this.hint, this.info);
}
