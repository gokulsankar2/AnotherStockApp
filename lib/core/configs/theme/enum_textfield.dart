import 'package:flutter/material.dart';

class EnumTextField<T> extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final List<T> enumValues;

  const EnumTextField({
    required this.hintText,
    required this.controller,
    required this.enumValues,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: enumValues.contains(controller.text) ? enumValues.firstWhere((e) => e.toString() == controller.text) : null,
      decoration: InputDecoration(
        hintText: hintText,
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      items: enumValues.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString().split('.').last),
        );
      }).toList(),
      onChanged: (T? newValue) {
        controller.text = newValue.toString();
      },
    );
  }
}