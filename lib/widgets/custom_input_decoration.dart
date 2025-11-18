import 'package:flutter/material.dart';

class CustomInputDecoration {
  final String label;
  final String hint;
  final Icon prefix;

  CustomInputDecoration(this.label, this.hint, this.prefix);

  InputDecoration customInputDecoration() {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
