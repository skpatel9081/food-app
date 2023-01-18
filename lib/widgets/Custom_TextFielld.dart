import 'package:flutter/material.dart';

class CostomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labText;
  final int? max;

  final TextInputType? keyboardType;
  CostomTextField({
    this.controller,
    this.keyboardType,
    required this.labText,
    this.max,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      maxLength: max,
      decoration: InputDecoration(
        labelText: labText,
      ),
    );
  }
}
