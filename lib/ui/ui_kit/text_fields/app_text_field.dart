import 'package:flutter/material.dart';
import 'package:ude/resources/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    this.hint = '',
    this.label = '',
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        label: Text(
          label,
          style: const TextStyle(color: AppColors.text),
        ),
      ),
    );
  }
}
