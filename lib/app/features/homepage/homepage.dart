library homepage;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanical_manufacturing_toolbox/app/config/routes/app_pages.dart';
import 'package:mechanical_manufacturing_toolbox/app/constans/app_constants.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/card_tool.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/header_text.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/list_tools.dart';
import 'package:mechanical_manufacturing_toolbox/app/shared_components/windows_app.dart';


part 'binding/homepage_binding.dart';
part 'controller/homepage_controller.dart';

class HomePageScreen extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    return _buildHomePage();
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
        controller: ScrollController(),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: HeaderText('装配分析工具'),
              )
            ],
          ),
          const SizedBox(height: kSpacing),
          _ToolInList(data: controller.assemblyTools),
          const SizedBox(height: kSpacing * 2),
          Row(
            children: [
              Expanded(
                child: HeaderText('定位分析工具'),
              )
            ],
          ),
          const SizedBox(height: kSpacing),
                    _ToolInList(data: controller.positioningTools),

          const SizedBox(height: kSpacing * 2),
          Row(
            children: [
              Expanded(
                child: HeaderText('其他工具'),
              )
            ],
          ),
          const SizedBox(height: kSpacing),
          _OtherToolsList(
            data: controller.otherTools,
          )
        ]));
  }
}

class _ToolInList extends StatelessWidget {
  const _ToolInList({
    required this.data,
    Key? key,
  }) : super(key: key);

  final List<CardToolData> data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kBorderRadius * 2),
      child: SizedBox(
        height: 250,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
            child: CardTool(
              data: data[index],
              primary: data[index].primaryColor,
              onPrimary: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Color _getSequenceColor(int index) {
  //   int val = index % 4;
  //   if (val == 3) {
  //     return Colors.indigo;
  //   } else if (val == 2) {
  //     return Colors.grey;
  //   } else if (val == 1) {
  //     return Colors.redAccent;
  //   } else {
  //     return Colors.lightBlue;
  //   }
  // }
}

class _OtherToolsList extends StatelessWidget {
  const _OtherToolsList({
    required this.data,
    Key? key,
  }) : super(key: key);

  final List<ListToolsData> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data
          .asMap()
          .entries
          .map(
            (e) => ListTools(
              data: e.value,
            ),
          )
          .toList(),
    );
  }
  
}
