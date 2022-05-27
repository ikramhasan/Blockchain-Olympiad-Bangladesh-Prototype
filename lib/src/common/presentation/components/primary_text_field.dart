import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextFormField(
          autovalidateMode: AutovalidateMode.always,
          controller: controller,
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label cannot be empty';
            }

            return null;
          },
        ),
      ],
    );
  }
}
