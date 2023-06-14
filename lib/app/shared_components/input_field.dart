import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechanical_manufacturing_toolbox/app/config/themes/app_theme.dart';

class NumberInputField extends StatefulWidget {
  final String label;
  final double initialValue;

  NumberInputField({required this.label, this.initialValue = 0.0});

  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style:subTitleStyle,
        ),
        SizedBox(height: 8.0),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
          ],
        ),
      ],
    );
  }
}