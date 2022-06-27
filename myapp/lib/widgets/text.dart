import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final int color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const TextCustom(
    {
      Key? key,
      required this.text,
      this.fontSize = 12,
      this.color = 0xffFFFFFF,
      this.fontWeight = FontWeight.w400,
      this.textAlign = TextAlign.left
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color(color),
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign
    );
  }
}