import 'package:flutter/material.dart';

goToPage(BuildContext context, Widget page) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}
