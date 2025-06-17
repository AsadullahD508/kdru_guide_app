import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? iconPath;
  final double iconSize;
  final double fontSize;
  final Color textColor;

  const SectionHeader({
    Key? key,
    required this.title,
    this.iconPath,
    this.iconSize = 30,
    this.fontSize = 20,
    this.textColor = const Color(0xFF0D3B66),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (iconPath != null) ...[
          Image.asset(
            iconPath!,
            width: iconSize,
            height: iconSize,
          ),
          const SizedBox(width: 12),
        ],
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontFamily: 'pashto',
            color: textColor,
          ),
        ),
      ],
    );
  }
}
