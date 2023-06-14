import 'package:mechanical_manufacturing_toolbox/app/constans/app_constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ListToolsData {
  final Icon icon;
  final String label;
  final String description;
  final Function()? onPressed;

  const ListToolsData({
    required this.icon,
    required this.label,
    required this.description,
    required this.onPressed,
  });
}

class ListTools extends StatelessWidget {
  const ListTools({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ListToolsData data;



  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: data.onPressed,
        hoverColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        leading: _buildIcon(),
        title: _buildTitle(),
        subtitle: _buildSubtitle(),
        trailing: _buildTrailing()
        );
  }

  Widget _buildIcon() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.withOpacity(.1),
      ),
      child: data.icon,
    );
  }

  Widget _buildTitle() {
    return Text(
      data.label,
      style: const TextStyle(fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      data.description,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTrailing() {
    return IconButton(
        onPressed: data.onPressed,
        color: kFontColorPallets[1],
        iconSize: 15,
        icon: const Icon(EvaIcons.arrowIosForwardOutline),
        splashRadius: 24,
        tooltip: "打开",
      
    );
  }
}
