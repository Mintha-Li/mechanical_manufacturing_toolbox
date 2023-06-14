import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mechanical_manufacturing_toolbox/app/config/routes/app_pages.dart';
import 'package:mechanical_manufacturing_toolbox/app/config/themes/app_theme.dart';
import 'package:get/get.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/global_box_manager.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {

    // Must add this line.
    windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
      size: Size(1280, 720),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      // titleBarStyle: TitleBarStyle.hidden,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      // await windowManager.setAsFrameless();
    });
    windowManager.setMinimumSize(Size(800, 600));
  }
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return GlobalBoxManager(child: 
//     GetMaterialApp(
//       title: '机械制造工艺工具箱',
//       theme: AppTheme.basic,
//       initialRoute: AppPages.initial,
//       getPages: AppPages.routes,
//       scrollBehavior: CustomScrollBehaviour(),
//       debugShowCheckedModeBanner: false,
//     ));
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return 
    GetMaterialApp(
      title: '机械制造工艺分析工具箱',
      theme: AppTheme.basic,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      scrollBehavior: CustomScrollBehaviour(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
