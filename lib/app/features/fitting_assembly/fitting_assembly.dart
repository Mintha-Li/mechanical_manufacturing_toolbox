import 'package:flutter/material.dart';

// 定义一个类表示尺寸链中的一个环
class Ring {
  double size; // 环的实际尺寸
  double tolerance; // 环的公差
  bool isCompensator; // 是否是补偿环

  Ring(this.size, this.tolerance, this.isCompensator);
}

// 定义一个函数用来计算修配装配法
double calculateFittingAssembly(List<Ring> rings) {
  // 检查输入是否合法
  if (rings == null || rings.isEmpty) {
    throw ArgumentError('rings cannot be null or empty');
  }
  // 找到补偿环
  Ring compensator = rings.firstWhere((ring) => ring.isCompensator);
  if (compensator == null) {
    throw ArgumentError('there must be a compensator ring');
  }
  // 计算尺寸链的总和和公差和
  double sum = 0;
  double tol = 0;
  for (Ring ring in rings) {
    sum += ring.size;
    tol += ring.tolerance;
  }
  // 计算补偿环需要修配的量
  double delta = sum - tol;
  // 返回修配后的尺寸链总和
  return sum - delta;
}

// 定义一个类表示UI界面的状态
class FittingAssemblyState extends State<FittingAssembly> {
  List<Ring> rings = []; // 存储用户输入的环列表
  double result =0; // 存储计算结果

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修配装配法'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: rings.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('环${index + 1}'),
                  subtitle: Text(
                      '尺寸：${rings[index].size}，公差：${rings[index].tolerance},${rings[index].isCompensator ? '补偿环' : '非补偿环'}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        rings.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text('添加环'),
                    onPressed: () async {
                      Ring? ring = await showDialog<Ring>(
                        context: context,
                        builder: (context) => AddRingDialog(),
                      );
                      if (ring != null) {
                        setState(() {
                          rings.add(ring);
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    child: Text('计算结果'),
                    onPressed: () {
                      try {
                        double result = calculateFittingAssembly(rings);
                        setState(() {
                          this.result = result;
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          if (result != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('修配后的尺寸链总和为：$result'),
            ),
        ],
      ),
    );
  }
}

// 定义一个类表示UI界面
class FittingAssembly extends StatefulWidget {
  @override
  FittingAssemblyState createState() => FittingAssemblyState();
}

// 定义一个类表示添加环的对话框
class AddRingDialog extends StatefulWidget {
  @override
  _AddRingDialogState createState() => _AddRingDialogState();
}

class _AddRingDialogState extends State<AddRingDialog> {
  TextEditingController sizeController = TextEditingController(); // 控制尺寸输入

  TextEditingController toleranceController = TextEditingController(); // 控制公差输入
  bool ? isCompensator = false; // 控制是否是补偿环

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('添加环'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: sizeController,
            decoration: InputDecoration(labelText: '尺寸'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: toleranceController,
            decoration: InputDecoration(labelText: '公差'),
            keyboardType: TextInputType.number,
          ),
          CheckboxListTile(
            value: isCompensator,
            onChanged: (value) {
              setState(() {
                isCompensator = value;
              });
            },
            title: Text('是否是补偿环'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('取消'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('确定'),
          onPressed: () {
            try {
              double size = double.parse(sizeController.text);
              double tolerance = double.parse(toleranceController.text);
              Ring ring = Ring(size, tolerance, isCompensator!);
              Navigator.pop(context, ring);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(e.toString()),
                duration: Duration(seconds: 2),
              ));
            }
          },
        ),
      ],
    );
  }
}