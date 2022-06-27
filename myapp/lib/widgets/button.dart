import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';

class Button extends StatelessWidget {
  final Widget child;
  final int color;
  final double height;
  final double width;
  final double borderRadius;
  final Function onPressed;

  const Button(
      {
        Key? key,
        required this.child,
        this.color = 0xff4249FF,
        required this.height,
        required this.width,
        this.borderRadius = 15,
        required this.onPressed
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: InkWell(
        onTap: () => onPressed(),
        child: Center(child: child)
        ),
      decoration: ShapeDecoration(
        color: Color(color),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: borderRadius,
            cornerSmoothing: 0.6 // iOS style corner smoothing
          ),
        ),
      ),
    );
  }
}
