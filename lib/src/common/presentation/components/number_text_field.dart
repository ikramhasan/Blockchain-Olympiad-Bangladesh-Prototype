import 'package:flutter/material.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            final number = int.tryParse(value!);
            if (number == null) {
              return 'Please enter a valid integer';
            } else if (number < 0) {
              return 'Number cannot be less than 0';
            } else if (number > 100) {
              return 'Number cannot be greater than 100';
            }
            return null;
          },
        ),
      ],
    );
  }
}
