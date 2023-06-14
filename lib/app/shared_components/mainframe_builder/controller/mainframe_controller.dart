part of mainframe_builder;

class MainFrameController extends GetxController {
  // 控制器的逻辑代码
  final navKey = GlobalKey<_BottomNavbarState>();
  //final scafoldKey = GlobalKey<ScaffoldState>();
  static MainFrameController get to => Get.find();

  var _currentIndex = 0.obs;

  final dataProfil = const UserProfileData(
    image: AssetImage(ImageRasterPath.logo),
    name: "同济大学",
    jobDesk: "管理员",
  );

  final pages = <String>['/homepage', '/settings'];

  // void openDrawer() {
  //   if (scafoldKey.currentState != null) {
  //     scafoldKey.currentState!.openDrawer();
  //   }
  // }

  void onPressedProfil() {}
  void searchTask(String value) {}

  void onSelectedMainMenu(int index, SelectionButtonData value) {
    _currentIndex.value = index;
    navKey.currentState?.changeSelected(index);
    Get.offAndToNamed(pages[index], id: 1);
  }

  void onSelectedNav(int index) {
    _currentIndex.value = index;
    Get.offAndToNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.homepage) {
      return GetPageRoute(
          settings: settings,
          page: () => HomePageScreen(),
          binding: HomePageBinding(),
          transition: Transition.zoom);
    } else if (settings.name == Routes.settings) {
      return GetPageRoute(
        settings: settings,
        page: () => SettingsScreen(),
        transition: Transition.zoom,
        binding: SettingsBinding(),
      );
    }
    return null;
  }
}
