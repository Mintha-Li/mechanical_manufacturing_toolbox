library mainframe_builder;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanical_manufacturing_toolbox/app/config/routes/app_pages.dart';
import 'package:mechanical_manufacturing_toolbox/app/config/themes/app_theme.dart';
import 'package:mechanical_manufacturing_toolbox/app/constans/app_constants.dart';
import 'package:mechanical_manufacturing_toolbox/app/features/fitting_assembly/fitting_assembly.dart';
import 'package:mechanical_manufacturing_toolbox/app/features/homepage/homepage.dart';
import 'package:mechanical_manufacturing_toolbox/app/features/other_tools/linear_interpolation.dart';
import 'package:mechanical_manufacturing_toolbox/app/features/settings/settings.dart';
import 'package:mechanical_manufacturing_toolbox/app/features/vblock/vblock.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/responsive_builder.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/search_field.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/selection_button.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/user_profile.dart';
import 'dart:io';
import 'package:window_manager/window_manager.dart';

part 'binding/mainframe_binding.dart';
part 'controller/mainframe_controller.dart';
part 'components/bottom_navbar.dart';
part 'components/main_menu.dart';

class MainFrameScreen extends GetView<MainFrameController> {
  MainFrameScreen({
    Key? key,
  }) : super(key: key);

  // 视图的UI代码
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(64),
      //   child: GestureDetector(
      //     behavior: HitTestBehavior.translucent,
      //     onPanStart: (details) {
      //       if (Platform.isWindows) windowManager.startDragging();
      //     },
      //     onDoubleTap: () {},
      //     child: AppBar(
      //       title: Text('机械制造工艺工具箱'),
      //       centerTitle: true,
      //       actions: [
      //         GestureDetector(
      //           behavior: HitTestBehavior.opaque,
      //           child: const Padding(
      //             padding: EdgeInsets.symmetric(horizontal: 16),
      //             child: Icon(
      //               Icons.close,
      //               size: 24,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      //key: controller.scafoldKey,
      drawer: ResponsiveBuilder.isDesktop(context)
          ? null
          : Drawer(
              child: SafeArea(
                child: SingleChildScrollView(child: _buildSidebar(context)),
              ),
            ),
      bottomNavigationBar: (ResponsiveBuilder.isDesktop(context) || kIsWeb)
          ? null
          : _BottomNavbar(
              key: controller.navKey, onSelected: controller.onSelectedNav),
      body: SafeArea(
        child: ResponsiveBuilder(
          mobileBuilder: (context, constraints) {
            return _buildRightContent(context: context);
          },
          tabletBuilder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: constraints.maxWidth > 800 ? 8 : 7,
                  child: _buildRightContent(context: context),
                  // ),
                ),
              ],
            );
          },
          desktopBuilder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: constraints.maxWidth > 1350 ? 3 : 4,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: _buildSidebar(context),
                  ),
                ),
                Flexible(
                  flex: constraints.maxWidth > 1350 ? 10 : 9,
                  child: _buildRightContent(),
                ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSpacing / 2),
        Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: Row(
              children: [
                Icon(Icons.build),
                SizedBox(width: kSpacing / 2),
                Text('机械制造工艺分析工具箱', style: titleStyle)
              ],
            )),
        const Divider(
          indent: 20,
          thickness: 1,
          endIndent: 20,
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: UserProfile(
            data: controller.dataProfil,
            onPressed: controller.onPressedProfil,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _MainMenu(onSelected: controller.onSelectedMainMenu),
        ),
        const Divider(
          indent: 20,
          thickness: 1,
          endIndent: 20,
          height: 30,
        ),
        const SizedBox(height: kSpacing),
        // Padding(
        //     padding: EdgeInsets.only(left: kSpacing / 2),
        //     child: Image.asset(
        //       ImageRasterPath.name,
        //       width: 200,
        //       height: 100,
        //     )),
        Padding(
          padding: EdgeInsets.all(kSpacing),
          child: Text("2023春机械制造工艺学课程大作业",
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: Text(
            "@2023 Tongji University",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildRightContent({BuildContext? context}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: Column(children: [
          const SizedBox(height: kSpacing),
          Row(
            children: [
              if (context != null)
                Padding(
                    padding: const EdgeInsets.only(right: kSpacing / 2),
                    child: Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(Icons.menu),
                        );
                      },
                    )),
              Expanded(
                child: SearchField(
                  onSearch: controller.searchTask,
                  hintText: "搜索一下",
                ),
              ),
            ],
          ),
          const SizedBox(height: kSpacing),
          Expanded(
            child: _buildContent(),
          )
        ]));
  }

  Widget _buildContent() {
    return Navigator(
        key: Get.nestedKey(1), // create a key by index
        initialRoute: '/homepage',
        onGenerateRoute: controller.onGenerateRoute);
  }
}
