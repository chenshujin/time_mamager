import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timecop/components/toast_widget.dart';
import 'package:timecop/extensions/text_widgets.dart';
import 'package:timecop/models/person.dart';
import 'package:timecop/screens/peson/widget/fill_info_double.dart';
import 'package:timecop/extensions/screen_utils.dart';
import '../../l10n.dart';

final Person ps = Person('', '李费费', 'LiFeiFei', '10/31', 'code');

class PersonInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonInfoState();
  }
}

class PersonInfoState extends State<PersonInfoPage> {
  final List<FillInfo> fills = [
    FillInfo('昵称', ps.nickName),
    FillInfo('生日', ps.birthDay),
    FillInfo('爱好', ps.hobby),
  ];

  PickedFile _imageFile;
  dynamic _pickImageError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10N.of(context).tr.personInfo),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              // 切换头像
              _onImageButtonPressed(ImageSource.gallery, context: context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.dp, vertical: 8.dp),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 0.5.dp, color: Colors.blueGrey))),
              child: Row(
                children: [
                  Expanded(
                    child: Text('头像'),
                  ),
                  Container(
                    width: 40.dp,
                    height: 40.dp,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.dp),
                      child: SimpleText('头像')
                      /*_imageFile != null
                          ? Image.file(File(_imageFile.path),width: 40.dp,height: 40.dp,fit: BoxFit.cover,)
                          : Image.network('')*/
                      ,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...fills
              .map((e) => FillInfoDouble(e, () async {
                var _endDate= DateTime.utc(1944, 6, 6);
                    DateTime newEndDate = await DatePicker.showDatePicker(
                        context,
                        currentTime: _endDate,
                        minTime: _endDate,
                        onChanged: (DateTime dt) => setState(() => _endDate =
                            DateTime(
                                dt.year, dt.month, dt.day, 23, 59, 59, 999)),
                        onConfirm: (DateTime dt) => setState(() => _endDate =
                            DateTime(
                                dt.year, dt.month, dt.day, 23, 59, 59, 999)),
                        theme: DatePickerTheme(
                          cancelStyle: Theme.of(context).textTheme.button,
                          doneStyle: Theme.of(context).textTheme.button,
                          itemStyle: Theme.of(context).textTheme.bodyText2,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        ));
                    bdsToast(msg: '${newEndDate.year}');
                    // _showProxyDialog(e);
                  }))
              .toList()
        ],
      ),
    );
  }

  //设置代理
  void _showProxyDialog(FillInfo info) {
    //设置代理
    showDialog<bool>(
        barrierDismissible: false, //点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('${info.hint}'),
            content: TextField(
              maxLines: 1,
              autofocus: true,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context); //令提示框消失
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () {
                  // 设置代理用来调试应用
                  //设置代理
                  Navigator.pop(context); //令提示框消失
                },
              )
            ],
          );
        });
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    await _displayPickImageDialog(context,
        (double maxWidth, double maxHeight, int quality) async {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    onPick(500, 500, null);
  }
}

typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);
