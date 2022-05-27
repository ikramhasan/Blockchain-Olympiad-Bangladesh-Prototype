import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    Key? key,
    required this.text,
    required this.subText,
    this.subTextWidget,
  }) : super(key: key);

  final String text;
  final String subText;
  final Widget? subTextWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 700,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Text(
                subText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              subTextWidget != null
                  ? Positioned(
                      left: 150,
                      top: -14,
                      child: subTextWidget!,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
