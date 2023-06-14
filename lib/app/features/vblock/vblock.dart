import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:mechanical_manufacturing_toolbox/app/config/themes/app_theme.dart';
import 'package:mechanical_manufacturing_toolbox/app/constans/app_constants.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/header_text.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/input_field.dart';

// class VBlockScreen extends GetView {
//   double calculateVBlockPositioningError(
//       double alpha, double dmax, double dmin, double td) {
//     double l1 = (1 / sin(alpha / 2)) * (dmax - dmin) / 2;
//     double l2 = td / (2 * sin(alpha / 2));
//     return l1 + l2;
//   }

//   @override
//   Widget build(BuildContext context) {
//     //return InputField(title: '1', hint: '1');
//     return Scaffold(body: SingleChildScrollView(
//         child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             BackButton(onPressed: () => Get.back()),
//             SizedBox(
//               width: kSpacing,
//             ),
//             Expanded(
//               child: Text(
//                 'V型块定位',
//                 style: subHeadingStyle,
//               ),
//             )
//           ],
//         ),
//         SizedBox(
//           height: kSpacing,
//         ),
//         Row(
//           children: [
//             Expanded(child: NumberInputField(label: '轴直径:')),
//             SizedBox(
//               width: kSpacing,
//             ),
//             Expanded(
//                 child: NumberInputField(
//               label: '上偏差：',
//             ))
//           ],
//         )
//       ],
//     )));
//   }
// }




class VBlockScreen extends StatefulWidget {
  @override
  _VBlockScreenState createState() =>
      _VBlockScreenState();
}

class _VBlockScreenState
    extends State<VBlockScreen> {
  final _shaftSizeController = TextEditingController();
  final _upperDeviationController = TextEditingController();
  final _lowerDeviationController = TextEditingController();
  final _vBlockAngleController = TextEditingController();
  double _positioningError = 0;

  void _calculatePositioningError() {
    double shaftSize = double.parse(_shaftSizeController.text);
    double upperDeviation = double.parse(_upperDeviationController.text);
    double lowerDeviation = double.parse(_lowerDeviationController.text);
    double vBlockAngle = double.parse(_vBlockAngleController.text);
    double vBlockHeight = shaftSize * tan(vBlockAngle);
    double vBlockWidth = shaftSize / cos(vBlockAngle);
    double upperVBlockHeight = vBlockHeight + upperDeviation;
    double lowerVBlockHeight = vBlockHeight - lowerDeviation;
    double upperVBlockWidth = vBlockWidth + upperDeviation;
    double lowerVBlockWidth = vBlockWidth - lowerDeviation;
    double upperPositioningError =
        sqrt(pow(upperVBlockHeight - vBlockHeight, 2) +
            pow(upperVBlockWidth - vBlockWidth, 2));
    double lowerPositioningError =
        sqrt(pow(lowerVBlockHeight - vBlockHeight, 2) +
            pow(lowerVBlockWidth - vBlockWidth, 2));
    setState(() {
      _positioningError = (upperPositioningError + lowerPositioningError) / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('V型块定位误差计算'),
        ),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '请输入轴的尺寸，上偏差及下偏差，V型块的角度',
          ),
          TextField(
            controller: _shaftSizeController,
            decoration: InputDecoration(
              hintText: '轴的尺寸',
            ),
          ),
          TextField(
            controller: _upperDeviationController,
            decoration: InputDecoration(
              hintText: '上偏差',
            ),
          ),
          TextField(
            controller: _lowerDeviationController,
            decoration: InputDecoration(
              hintText: '下偏差',
            ),
          ),
          TextField(
            controller: _vBlockAngleController,
            decoration: InputDecoration(
              hintText: 'V型块的角度',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _calculatePositioningError();
            },
            child: Text('计算'),
          ),
          Text('定位误差大小：$_positioningError'),
        ],
      ),
    ));
  }
}