part of 'app_pages.dart';

/// used to switch pages
class Routes {
  static const mainframe = _Paths.mainframe;
  static const homepage = _Paths.homepage;
  static const settings = _Paths.settings;
  static const vblock = _Paths.vblock;
  static const linearInterp = _Paths.linearInterp;
  static const fittingAssembly = _Paths.fittingAssembly;
  static const toleranceCalculator = _Paths.toleranceCalculator;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const mainframe = '/';
  static const homepage = '/homepage';
  static const settings = '/settings';
  static const vblock = '/vblock';
  static const linearInterp = '/linearInterp';
  static const fittingAssembly = '/fittingAssembly';
  static const toleranceCalculator = '/toleranceCalculator';

  // Example :
  // static const index = '/';
  // static const splash = '/splash';
  // static const product = '/product';
}
