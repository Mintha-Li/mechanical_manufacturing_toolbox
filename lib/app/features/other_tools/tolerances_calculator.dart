import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechanical_manufacturing_toolbox/app/config/themes/app_theme.dart';

List<List<double>> table = [
  [3, 6, 10, 18, 30, 50, 80, 120, 180, 250, 315, 400, 500],
  [0.8, 1, 1, 1.2, 1.5, 1.5, 2, 2.5, 3.5, 4.5, 6, 7, 8],
  [1.2, 1.5, 1.5, 2, 2.5, 2.5, 3, 4, 5, 7, 8, 9, 10],
  [2, 2.5, 2.5, 3, 4, 4, 5, 6, 8, 10, 12, 13, 15],
  [3, 4, 4, 5, 6, 7, 8, 10, 12, 14, 16, 18, 20],
  [4, 5, 6, 8, 9, 11, 13, 15, 18, 20, 23, 25, 27],
  [6, 8, 9, 11, 13, 16, 19, 22, 25, 29, 32, 36, 40],
  [10, 12, 15, 18, 21, 25, 30, 35, 40, 46, 52, 57, 63],
  [14, 18, 22, 27, 33, 39, 46, 54, 63, 72, 81, 89, 97],
  [25, 30, 36, 43, 52, 62, 74, 87, 100, 115, 130, 140, 155],
  [40, 48, 58, 70, 84, 100, 120, 140, 160, 185, 210, 230, 250]
];

class ToleranceCalculator extends StatefulWidget {
  @override
  _ToleranceCalculatorState createState() => _ToleranceCalculatorState();
}

class _ToleranceCalculatorState extends State<ToleranceCalculator> {
  TextEditingController _basicSizeController = TextEditingController();
  String _toleranceGrade = 'IT7';
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('公差计算器'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _basicSizeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '基本尺寸（单位：mm）',
                hintText: '请输入基本尺寸',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '公差等级：',
                      style: titleStyle,
                    ),
                    DropdownButton<String>(
                      value: _toleranceGrade,
                      onChanged: (String? newValue) {
                        setState(() {
                          _toleranceGrade = newValue!;
                        });
                      },
                      items: <String>['IT6', 'IT7', 'IT8', 'IT9', 'IT10']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    double basicSize =
                        double.tryParse(_basicSizeController.text) ?? 0;
                    //String toleranceGrade = _toleranceGradeController.text;
                    double tolerance = getTolerance(basicSize, _toleranceGrade);
                    setState(() {
                      if (tolerance is String) {
                        _result = tolerance.toStringAsFixed(2);
                      } else {
                        _result = tolerance.toStringAsFixed(2);
                      }
                    });
                  },
                  child: Text('计算'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 20.0),
            Text(
              '公差值: $_result μm',
              style: titleStyle,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: _result));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('复制成功'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: Text('复制结果'),
            ),
          ],
        ),
      ),
    );
  }

  double getTolerance(double basicSize, String toleranceGrade) {
    int grade = int.parse(toleranceGrade.substring(2));
    // 检查输入参数是否有效
    if (basicSize <= 0 || grade < 1 || grade > 18) {
      return -9999.99; // 返回一个错误值
    }
    // 找到基本尺寸所在的范围
    int row = 0;
    for (int i = 0; i < table[0].length; i++) {
      if (basicSize <= table[0][i]) {
        row = i;
        break;
      }
    }
    // 找到标准公差等级所在的列
    int col = int.parse(toleranceGrade.substring(2)) - 1;
    // 检查表格中是否有对应的公差值
    if (col >= table.length - 1 || row >= table[col + 1].length) {
      return -9999.99; // 返回一个错误值
    }
    // 直接返回公差值
    return table[col + 1][row];
  }
}
