import 'package:flutter/material.dart';
import '../constants.dart';

class ProjectSection extends StatefulWidget {
  final String title;
  final String description;
  final List<Map<String, dynamic>> imageItems;

  const ProjectSection({
    required this.title,
    required this.description,
    this.imageItems = const [],
    super.key,
  });

  @override
  State<ProjectSection> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double widthAdjust = (width / 1496).clamp(0.4, 1.5);

    //TODO: Alter this for the completed project pages and possibly make this a passed value so projects where pictures take up less space can be moved later than those that take up more
    bool isScreenTooSmall = width < 1100; // Threshold for small screen layout

    //TODO: When the pictures move below the text allow them to be placed one beside the other if they can fit as such to allow for the space on the webpage to be better used
    return Padding(
      padding: EdgeInsets.fromLTRB(65 * widthAdjust, 50, 50 * widthAdjust, 30),
      child: isScreenTooSmall
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Title and Description
                Text(
                  widget.title,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: textColor,
                    fontSize: subtitleSize * widthAdjust.clamp(0.75, 1.5),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SpaceGrotesk',
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.description,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: textColor,
                    fontSize: (textSize - 4) * widthAdjust.clamp(0.75, 1.5),
                    fontFamily: 'Roboto',
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),

                // Centered Images Below Text
                Center(
                  child: Column(
                    children: widget.imageItems.map<Widget>((item) {
                      final int index = widget.imageItems.indexOf(item) + 1;
                      final EdgeInsetsGeometry padding =
                          item['padding'] ?? EdgeInsets.zero;

                      //TODO: Alter this so that if no description is provided there is no text widget to go along with the picture and instead it is just a picture provided
                      Widget figureText = item['description'] != null
                          ? Text(
                              'Figure $index: ${item['description']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textColor,
                                fontSize: (textSize - 6) *
                                    widthAdjust.clamp(0.75, 1.5),
                                fontFamily: 'Roboto',
                              ),
                            )
                          : const SizedBox();

                      return Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(
                              'images/${item['image']}',
                              width: item['width'] ?? 100.0,
                              height: item['height'] ?? 100.0,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            if (item['description'] != null) figureText,
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text Section
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: textColor,
                          fontSize: subtitleSize * widthAdjust.clamp(0.75, 1.5),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SpaceGrotesk',
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.description,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: textColor,
                          fontSize:
                              (textSize - 4) * widthAdjust.clamp(0.75, 1.5),
                          fontFamily: 'Roboto',
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Images Section (beside the text)
                Expanded(
                  flex: 1,
                  child: Column(
                    children: widget.imageItems.map<Widget>((item) {
                      final int index = widget.imageItems.indexOf(item) + 1;
                      final EdgeInsetsGeometry padding =
                          item['padding'] ?? EdgeInsets.zero;

                      Widget figureText = item['description'] != null
                          ? Text(
                              'Figure $index: ${item['description']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textColor,
                                fontSize: (textSize - 6) *
                                    widthAdjust.clamp(0.75, 1.5),
                                fontFamily: 'Roboto',
                              ),
                            )
                          : const SizedBox();

                      String position = item['figureTextPosition'] ?? 'below';
                      String besidePosition = item['besidePosition'] ?? 'right';

                      switch (position) {
                        case 'above':
                          return Padding(
                            padding: padding,
                            child: Column(
                              children: [
                                figureText,
                                const SizedBox(height: 10),
                                Image.asset(
                                  'images/${item['image']}',
                                  width: item['width'] ?? 100.0,
                                  height: item['height'] ?? 100.0,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          );
                        case 'beside':
                          return Padding(
                            padding: padding,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: besidePosition == 'right'
                                  ? [
                                      Image.asset(
                                        'images/${item['image']}',
                                        width: item['width'] ?? 100.0,
                                        height: item['height'] ?? 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: figureText,
                                        ),
                                      ),
                                    ]
                                  : [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: figureText,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Image.asset(
                                        'images/${item['image']}',
                                        width: item['width'] ?? 100.0,
                                        height: item['height'] ?? 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                            ),
                          );
                        case 'below':
                        default:
                          return Padding(
                            padding: padding,
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/${item['image']}',
                                  width: item['width'] ?? 100.0,
                                  height: item['height'] ?? 100.0,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 10),
                                if (item['description'] != null) figureText,
                                const SizedBox(height: 20),
                              ],
                            ),
                          );
                      }
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
