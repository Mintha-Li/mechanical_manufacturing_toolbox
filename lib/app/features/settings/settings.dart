import 'package:cupertino_setting_control/cupertino_setting_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsScreen extends GetView<SettingsController> {
  Widget _buildTileTitle(String title) {
    return Padding(
        padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
        child: Text(title,
            style: TextStyle(
              color: CupertinoColors.systemBlue,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )));
  }

  _launchURL() async {
    const url =
        'https://ww2.mathworks.cn/products/compiler/matlab-runtime.html';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final basicTile = Material(
        color: Colors.transparent,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildTileTitle('通用'),
          SettingRow(
            rowData: SettingsButtonConfig(
              title: '运行库安装',
              tick: true,
              functionToCall: () {
                _launchURL();
              },
            ),
            config: SettingsRowConfiguration(),
            onSettingDataRowChange: () {},
          ),
        ]));

    final aboutTile = Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTileTitle('关于'),
          SettingRow(
            rowData: SettingsButtonConfig(
              title: '制作人员信息',
              tick: true,
              functionToCall: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('制作人员'),
                      content: Text('李明达\t范庭尧\t任江龙\t李君\t谢程祾'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('关闭'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            config: SettingsRowConfiguration(),
            onSettingDataRowChange: () {},
          ),
          SettingRow(
            rowData: SettingsButtonConfig(
              title: '版权信息',
              tick: true,
              functionToCall: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('版权信息'),
                      content: Text(
                          'Copyright © 2023 Tongji University. All rights reserved.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('关闭'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            config: SettingsRowConfiguration(),
            onSettingDataRowChange: () {},
          )
        ],
      ),
    );

    final List<Widget> widgetList = [
      basicTile,
      SizedBox(height: 15),
      aboutTile,
    ];

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: widgetList,
        ));
  }
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}

class SettingsController extends GetxController {}
