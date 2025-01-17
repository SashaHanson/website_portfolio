import 'package:flutter/material.dart';
import '/constants.dart';

class HomeTitlePage extends StatelessWidget {
  final double height;
  final double width;

  const HomeTitlePage({required this.height, required this.width, super.key});

  // Function to calculate dynamic font size based on screen height and width
  double _getResponsiveFontSize(double baseSize) {
    double scaleFactorH = (height / 892).clamp(0.6, 1.1);
    double scaleFactorW = (width / 1496).clamp(0.6, 1.1);
    return baseSize * scaleFactorH * scaleFactorW;
  }

  @override
  Widget build(BuildContext context) {
    double depTitleSize = _getResponsiveFontSize(titleSize);
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'images/cnc_machine_2k.jpg'), // Or use AssetImage for local images
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: _getResponsiveFontSize(44.0), // Adjust horizontal padding
              bottom: _getResponsiveFontSize(
                  30.0), // Adjust bottom padding for positioning
            ),
            child: Container(
              alignment: AlignmentDirectional.bottomStart,
              //TODO: Add a fade in animation from left to right that only appears upon entering the site or returning to this screen from another screen
              child: Text(
                'ENGINEER \nINNOVATOR \nHOBBYIST',
                style: TextStyle(
                  color: textColor,
                  fontSize: depTitleSize,
                  height: 0.9,
                  fontFamily: 'Aldrich',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
