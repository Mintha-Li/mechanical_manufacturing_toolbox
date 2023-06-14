import 'package:flutter/material.dart';
import 'package:mechanical_manufacturing_toolbox/app/features/fitting_assembly/fitting_assembly.dart';
import 'package:mechanical_manufacturing_toolbox/app/features/other_tools/linear_interpolation.dart';
import 'package:mechanical_manufacturing_toolbox/app/features/other_tools/tolerances_calculator.dart';
import 'package:mechanical_manufacturing_toolbox/app/features/vblock/vblock.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/mainframe_builder/mainframe.dart';

import 'package:get/get.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.mainframe;

  static final routes = [
    GetPage(
        name: Routes.mainframe,
        page: () => MainFrameScreen(),
        bindings: [MainFrameBinding()]),
    GetPage(
        name: Routes.vblock,
        page: () => VBlockScreen(),
        transition: Transition.leftToRightWithFade),
    GetPage(
        name: Routes.linearInterp,
        page: () => LinearInterpolation(),
        transition: Transition.leftToRightWithFade),
    GetPage(
        name: Routes.fittingAssembly,
        page: () => FittingAssembly(),
        transition: Transition.leftToRightWithFade),
    GetPage(
        name: Routes.toleranceCalculator,
        page: () => ToleranceCalculator(),
        transition: Transition.leftToRightWithFade),

  ];
}
