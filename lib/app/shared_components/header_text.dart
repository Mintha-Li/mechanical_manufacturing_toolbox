import 'package:flutter/material.dart';
import 'package:mechanical_manufacturing_toolbox/app/config/themes/app_theme.dart';

class HeaderText extends StatelessWidget {
  const HeaderText(this.data, {Key? key}) : super(key: key);

  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.start,
      style: headingStyle);
  }
}
