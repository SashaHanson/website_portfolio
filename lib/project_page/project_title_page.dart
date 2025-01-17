import 'package:flutter/material.dart';
import 'package:website_portfolio/constants.dart';

class ProjectTitlePage extends StatelessWidget {
  const ProjectTitlePage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; // 892 for my screen
    double width = MediaQuery.of(context).size.width; // 1496 for my screen
    // Adjust height and width to allow for active resizing when the screen size changes
    double heightAdjustment = (height / 892).clamp(0.6, 1.5);
    double widthAdjustment = (width / 1496).clamp(0.7, 1.5);

    return Stack(
      children: <Widget>[
        Container(
          height: (height * 0.25).clamp(130, 500), // Define height
          width: width, // Define width
          color: bannerColor,
          child: Padding(
            padding: EdgeInsets.only(top: 108 * heightAdjustment),
            child: Text(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: projectTextSize * widthAdjustment,
                fontWeight: FontWeight.bold,
                fontFamily: 'SpaceGrotesk',
                height: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
