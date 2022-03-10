import 'package:flutter/material.dart';

class CustomeFormField extends StatelessWidget {
  const CustomeFormField(
      {Key? key, required this.label, required this.controller})
      : super(key: key);
  final String label;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        label: Text(label),
        focusColor: const Color(0xFFAE9387),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
