part of homepage;

class HomePageController extends GetxController {
  final positioningTools = [
    CardToolData(
      label: "心轴定位误差计算",
      category: "开发中……",
      primaryColor: Colors.red,
      onPressed: () {},
      onPressedButton: () {},
    ),
    CardToolData(
      label: "V形块定位误差计算",
      category: "开发中……",
      primaryColor: Colors.purple,
      onPressed: () => Get.toNamed(Routes.vblock),
      onPressedButton: () {
        Get.toNamed(Routes.vblock);
      },
    ),
  ];
  final assemblyTools = [
    CardToolData(
        label: "修配装配法计算系统",
        category: "尺寸链计算",
        primaryColor: Colors.blue,
        onPressed: () {
          WindowsApp('fitting_assembly\\Fitting_Assembly.exe', '').launch();
        },
        onPressedButton: () {
          WindowsApp('fitting_assembly\\Fitting_Assembly.exe', '').launch();
        }),
    CardToolData(
      label: "正态分布法计算系统",
      category: "仍在开发...",
      primaryColor: Colors.indigo,
      onPressed: () {},
      onPressedButton: () {},
    ),
    CardToolData(
      label: "点图法计算系统",
      category: "仍在开发...",
      primaryColor: Colors.lightBlue,
      onPressed: () {},
      onPressedButton: () {},
    ),
    CardToolData(
      label: "互换装配法计算系统",
      category: "仍在开发...",
      primaryColor: Colors.cyan,
      onPressed: () {},
      onPressedButton: () {},
    ),
    CardToolData(
      label: "分组选配法计算系统",
      category: "仍在开发...",
      primaryColor: Colors.teal,
      onPressed: () {},
      onPressedButton: () {},
    ),
    CardToolData(
      label: "调整装配法计算系统",
      category: "仍在开发...",
      primaryColor: Colors.blueGrey,
      onPressed: () {},
      onPressedButton: () {},
    ),
  ];

  final otherTools = [
    ListToolsData(
        icon: const Icon(EvaIcons.monitor, color: Colors.blueGrey),
        label: "线性插值计算器",
        description: "二维线性插值计算",
        onPressed: () {
          Get.toNamed(Routes.linearInterp);
        }),
    ListToolsData(
        icon: const Icon(Icons.table_chart, color: Colors.orange),
        label: "公差计算器",
        description: "公差计算",
        onPressed: () {
          Get.toNamed(Routes.toleranceCalculator);
        }),
  ];
}
