import 'package:flutter/material.dart';

class CustomeFormField extends StatelessWidget {
  const CustomeFormField(
      {Key? key, required this.label, required this.controller, bool? obscure})
      : _obscure = obscure ?? false,
        super(key: key);
  final String label;
  final TextEditingController controller;
  final bool _obscure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscure,
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
