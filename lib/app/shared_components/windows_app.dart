import 'dart:io';

import 'package:win32/win32.dart';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as p;

class WindowsApp {
  // a constructor that takes the app path and parameters as arguments
  WindowsApp(this.appPath, this.appParams);

  // a field to store the app path
  String appPath;

  // a field to store the app parameters
  String appParams;

  // a method to launch the app
  bool launch() {
    try {
      String resolvedExecutablePath = Platform.resolvedExecutable;
      String rootPath = p.dirname(resolvedExecutablePath);
      final exeFilePath =
          p.join(rootPath, 'data', 'flutter_assets', 'apps', appPath);

      // convert the strings to native UTF-16 format
      final verb = 'open'.toNativeUtf16();
      final process = exeFilePath.toNativeUtf16();
      final params = appParams.toNativeUtf16();
      final nullParams = ''.toNativeUtf16();

      // use ShellExecute to launch the app
      ShellExecute(0, verb, process, params, nullParams, SW_SHOW);

      // free the allocated memory
      free(verb);
      free(process);
      free(params);
      free(nullParams);

      // return true if successful
      return true;
    } catch (_) {
      // return false if failed
      return false;
    }
  }

  void openApp() async {
    String resolvedExecutablePath = Platform.resolvedExecutable;
    String rootPath = p.dirname(resolvedExecutablePath);
    final exeFilePath =
        p.join(rootPath, 'data', 'flutter_assets', 'apps', appPath);
    final appFile = File(exeFilePath);
    if (appFile.existsSync()) {
      // 执行应用程序
      final result = await Process.run(appFile.path, []);
      if (result.exitCode == 0) {
        // 等待应用程序退出
        print('应用程序已成功退出！');
      } else {
        print('无法启动应用程序：${result.stderr}');
      }
    } else {
      print('找不到应用程序文件：${appFile.path}');
    }
  }
}
