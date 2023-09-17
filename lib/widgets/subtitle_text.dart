import 'package:flutter/material.dart';

class SubtitleTextWidget extends StatelessWidget {
  const SubtitleTextWidget(
      {super.key,
      required this.label,
      this.fontSize = 18,
      this.fontStyle = FontStyle.normal,
      this.fontWeight = FontWeight.normal,
      this.color,
      this.textDecoration = TextDecoration.none,
      this.textAlign = TextAlign.start});

  final String label;
  final double fontSize;
  final FontStyle fontStyle;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration textDecoration;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        color: color,
        fontStyle: fontStyle,
      ),
      textAlign: textAlign,
    );
  }
}
