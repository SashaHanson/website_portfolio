import 'package:flutter/material.dart';
import '/constants.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:glass/glass.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    required this.screenWidth,
    required this.padding,
    required this.title,
    required this.textItems,
    this.iconButtons = const [], // New property for IconButton widgets
    this.titleAlignment = Alignment.center,
    required this.isBubble,
    super.key,
  });

  final double screenWidth;
  final EdgeInsetsGeometry padding;
  final String title;
  final List<Map<String, dynamic>> textItems;
  final List<Widget> iconButtons; // Allow any widget, not just IconButton
  final AlignmentGeometry titleAlignment;
  final bool isBubble;
  final int maxTextLines = 15;
  final int maxTitleLines = 1;

  double _getResponsiveFontSize(double baseSize) {
    double scaleFactor = (screenWidth / 1496).clamp(0.7, 1.2);
    return baseSize * scaleFactor;
  }

  double _calculateTextHeight(
      String text, TextStyle style, double maxWidth, int maxLines) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
    )..layout(maxWidth: maxWidth);

    final double lineHeight = style.height != null
        ? style.height! * style.fontSize!
        : style.fontSize!;

    return lineHeight * textPainter.computeLineMetrics().length;
  }

  double get sectionHeight {
    double totalTextHeight = 45;
    double depSubtitleSize = _getResponsiveFontSize(subtitleSize);
    double depTextSize = _getResponsiveFontSize(textSize);

    final double titleHeight = _calculateTextHeight(
      title,
      TextStyle(
        fontSize: depSubtitleSize,
        fontWeight: FontWeight.bold,
        fontFamily: 'SpaceGrotesk',
        height: 1.2,
      ),
      screenWidth - padding.horizontal,
      maxTitleLines,
    );

    for (var item in textItems) {
      if (item.containsKey('texts') &&
          item['texts'] is List &&
          item['texts'].isNotEmpty) {
        var firstText = item['texts'][
            0]; // Calculate height only for the first text entry in the 'texts' list

        totalTextHeight += _calculateTextHeight(
          firstText,
          TextStyle(
            fontSize: depTextSize,
            fontFamily: 'Roboto',
            height: 1.5,
          ),
          screenWidth - padding.horizontal,
          maxTextLines,
        );
      } else if (item.containsKey('text')) {
        totalTextHeight += _calculateTextHeight(
          item['text'],
          TextStyle(
            fontSize: depTextSize,
            fontFamily: 'Roboto',
            height: 1.5,
          ),
          screenWidth - padding.horizontal,
          maxTextLines,
        );
      }
    }

    if (iconButtons.isNotEmpty) {
      totalTextHeight += 40; // Approximate height for a row of IconButtons
    }

    return titleHeight + totalTextHeight;
  }

  @override
  Widget build(BuildContext context) {
    double depSubtitleSize = _getResponsiveFontSize(subtitleSize);
    double depTextSize = _getResponsiveFontSize(textSize);

    return Stack(
      children: [
        if (isBubble)
          Stack(
            children: [
              Padding(
                padding:
                    padding.subtract(const EdgeInsets.fromLTRB(18, 13, 18, 0)),
                child: Container(
                  height: sectionHeight - 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //TODO: possibly alter gradient to change direction depending on orientation of section
                    gradient: const LinearGradient(
                      colors: [Colors.black, Colors.black12],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    padding.subtract(const EdgeInsets.fromLTRB(18, 13, 18, 0)),
                child: Container(
                  height: sectionHeight - 4,
                ).asGlass(
                  blurX: 0,
                  blurY: 0,
                  clipBorderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        Padding(
          padding: padding.subtract(const EdgeInsets.fromLTRB(20, 15, 20, 0)),
          child: SizedBox(
            height: sectionHeight,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                //TODO: possibly alter gradient to change direction depending on orientation of section
                border: const GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueGrey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: padding,
          child: Column(
            children: <Widget>[
              // Title rendering
              Container(
                alignment: titleAlignment,
                child: Text(
                  title,
                  maxLines: maxTitleLines,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: depSubtitleSize,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SpaceGrotesk',
                    height: 1.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Text items rendering
              ...textItems.map<Widget>(
                (item) {
                  if (item.containsKey('texts')) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth < 600
                              ? 0
                              : 90 * (screenWidth / 1496).clamp(0.3, 1.2),
                        ),
                        for (var i = 0; i < item['texts'].length; i++)
                          Expanded(
                            child: Container(
                              alignment: (item['alignments'] is List &&
                                      i < item['alignments'].length)
                                  ? item['alignments'][i]
                                  : Alignment.topLeft,
                              child: Text(
                                item['texts'][i],
                                textAlign: TextAlign.left,
                                maxLines: maxTextLines,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: depTextSize - 1,
                                  fontFamily: 'Roboto',
                                  height: 1.5,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                      ],
                    );
                  }
                  return Container(
                    alignment: item['alignment'] ?? Alignment.topLeft,
                    child: Text(
                      item['text'],
                      textAlign: item['textAlign'],
                      maxLines: maxTextLines,
                      style: TextStyle(
                        color: textColor,
                        fontSize: depTextSize,
                        fontFamily: 'Roboto',
                        height: 1.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
              // IconButtons rendering below text items with possible SizedBox
              if (iconButtons.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < iconButtons.length; i++) ...[
                      iconButtons[i],
                      if (i != iconButtons.length - 1)
                        const SizedBox(
                            width: 16), // Add a SizedBox between buttons
                    ],
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
