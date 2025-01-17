import 'package:flutter/material.dart';
import 'constants.dart';

class CopyrightNotice extends StatelessWidget {
  const CopyrightNotice(
      {required this.width, required this.widthAdjust, super.key});
  final double width;
  final double widthAdjust;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100 * widthAdjust.clamp(0.7, 1.2),
      width: width,
      color: copyrightColor,
      child: Center(
        child: Text(
          'Copyright © 2025 Sasha Difelice Hanson',
          style: TextStyle(
            color: textColor,
            fontSize: textSize * widthAdjust.clamp(0.7, 1.2),
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
