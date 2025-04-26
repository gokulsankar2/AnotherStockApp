import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicTextField extends StatelessWidget {
  final String hintText;
  final bool? obscureText;
  final bool? decimal;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const BasicTextField({
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.decimal,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      obscuringCharacter: String.fromCharCode(0x2022),
      keyboardType: decimal == true ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      inputFormatters: decimal == true ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))] : [],
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: hintText,
        suffixIcon: obscureText == true ? Icon(Icons.visibility_off) : null,
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      onChanged: onChanged,
    );
  }
}
