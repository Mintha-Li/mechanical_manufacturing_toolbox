import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechanical_manufacturing_toolbox/app/config/themes/app_theme.dart';

class LinearInterpolation extends StatefulWidget {
  @override
  _LinearInterpolationState createState() => _LinearInterpolationState();
}

class _LinearInterpolationState extends State<LinearInterpolation> {
  TextEditingController x1Controller = TextEditingController();
  TextEditingController y1Controller = TextEditingController();
  TextEditingController x2Controller = TextEditingController();
  TextEditingController y2Controller = TextEditingController();
  TextEditingController targetXController = TextEditingController();
  String result = '';

  void calculate() {
    double x1 = double.tryParse(x1Controller.text) ?? 0.0;
    double y1 = double.tryParse(y1Controller.text) ?? 0.0;
    double x2 = double.tryParse(x2Controller.text) ?? 0.0;
    double y2 = double.tryParse(y2Controller.text) ?? 0.0;
    double targetX = double.tryParse(targetXController.text) ?? 0.0;

    double resultY = y1 + (targetX - x1) * (y2 - y1) / (x2 - x1);

    setState(() {
      result = '$resultY';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('线性插值计算器')),
        body:SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                Text('输入已知的 (x1,y1) 与 (x2,y2):',style: titleStyle,),
                SizedBox(height: 16.0),

                // LayoutBuilder(builder: (context, constraints) {
                //   bool useVerticalLayout = constraints.maxWidth < 1000.0;
                //   return Flex(
                //     direction:
                //         useVerticalLayout ? Axis.vertical : Axis.horizontal,
                //     children: [
                //       SizedBox(
                //         width: 100,
                //         child: TextField(
                //           controller: x1Controller,
                //           decoration: InputDecoration(
                //             labelText: 'x1',
                //             border: OutlineInputBorder(),
                //           ),
                //           keyboardType: TextInputType.number,
                //         ),
                //       ),
                //       SizedBox(height: 16.0),
                //       SizedBox(
                //         width: 100,
                //         child: TextField(
                //           controller: y1Controller,
                //           decoration: InputDecoration(
                //             labelText: 'y1',
                //             border: OutlineInputBorder(),
                //           ),
                //           keyboardType: TextInputType.number,
                //         ),
                //       )
                //     ],
                //   );
                // }),
                TextField(
                  controller: x1Controller,
                  decoration: InputDecoration(
                    labelText: 'x1',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 16.0),
                TextField(
                  controller: y1Controller,
                  decoration: InputDecoration(
                    labelText: 'y1',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                //SizedBox(height: 16.0),
                SizedBox(height: 16.0),
                TextField(
                  controller: x2Controller,
                  decoration: InputDecoration(
                    labelText: 'x2',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: y2Controller,
                  decoration: InputDecoration(
                    labelText: 'y2',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 32.0),
                Text('输入目标 x 值:',style: titleStyle,),
                SizedBox(height: 16.0),
                TextField(
                  controller: targetXController,
                  decoration: InputDecoration(
                    labelText: 'Target x',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: calculate,
                  child: Text('计算结果'),
                ),
                SizedBox(height: 16.0),
                Text('结果：$result',style: titleStyle,),
                                SizedBox(height: 32.0),
                ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: result));
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
}
