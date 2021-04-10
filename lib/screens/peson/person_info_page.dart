import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timecop/components/toast_widget.dart';
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
                      child: _imageFile != null
                          ? Image.file(File(_imageFile.path))
                          : Image.network(''),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...fills
              .map((e) => FillInfoDouble(e, () {
                    bdsToast(msg: e.info);
                  }))
              .toList()
        ],
      ),
    );
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
