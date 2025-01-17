import 'package:flutter/material.dart';
import 'reusable_banner_button.dart';
import '/constants.dart';
import 'package:glass/glass.dart';
import 'dart:ui'; // Import for BackdropFilter

//TODO: make banner background transparent until you scroll down and then it becomes the frosted glass
class BannerWidget extends StatefulWidget {
  final List<Map<String, dynamic>>
      navItems; // List of nav items with titles and callbacks
  final List<Map<String, dynamic>>
      logoItems; // List of logo items with titles and callbacks
  final double heightAdjust;

  const BannerWidget({
    required this.navItems, // Dynamic nav items passed in
    required this.logoItems, // Dynamic list of logo items (can be multiple)
    required this.heightAdjust,
    super.key,
  });

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget>
    with SingleTickerProviderStateMixin {
  static const double thresholdWidth = 750;
  static const double textSpacing = 22;
  static const double iconSpacing = 15;

  bool isMenuVisible = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _blurOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
            begin: const Offset(1, 0), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _blurOpacityAnimation = Tween<double>(begin: 0.0, end: 0.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isMenuVisible = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          isMenuVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (isMenuVisible) {
      _controller.reverse();
    } else {
      setState(() {
        isMenuVisible = true;
      });
      _controller.forward();
    }
  }

  void _checkScreenSizeAndToggleMenu(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= thresholdWidth && isMenuVisible) {
      _toggleMenu();
    }
  }

  Widget _buildTextButton(String text, VoidCallback onPress) {
    return ReusableBannerButton(
      buttonCard: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: textSize * widget.heightAdjust.clamp(0.8, 1.2),
          fontFamily: 'Roboto',
        ),
      ),
      onPress: onPress,
      heightAdjust: widget.heightAdjust.clamp(0.8, 1.2),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPress) {
    return ReusableBannerButton(
      buttonCard: Icon(icon, color: textColor),
      onPress: onPress,
      heightAdjust: widget.heightAdjust.clamp(0.8, 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    double rowHeightAdjust = widget.heightAdjust.clamp(0.8, 1.2);
    double columnHeightAdjust = widget.heightAdjust.clamp(0.5, 1.5);
    final isCompact = MediaQuery.of(context).size.width < thresholdWidth;
    _checkScreenSizeAndToggleMenu(context);
    double textAdjust = textSize * rowHeightAdjust;

    return Stack(
      children: [
        if (isMenuVisible)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5.0 * _controller.value,
                    sigmaY: 5.0 * _controller.value,
                  ),
                  child: Opacity(
                    opacity: _blurOpacityAnimation.value,
                    child: Container(color: Colors.black.withOpacity(0.5)),
                  ),
                );
              },
            ),
          ),
        Material(
          color: Colors.transparent,
          elevation: 5,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 68 * rowHeightAdjust,
            color: bannerColor.withOpacity(0.55),
            padding: EdgeInsets.symmetric(
                vertical: 20 * rowHeightAdjust, horizontal: 30),
            child: Row(
              children: [
                // Logo buttons (could be multiple)
                Row(
                  //TODO 3: add logo beside name and make this button static sending the user to the top of the main page
                  children: widget.logoItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(right: textSpacing),
                      child: ReusableBannerButton(
                        buttonCard: Text(
                          item['title'],
                          style: TextStyle(
                            color: textColor,
                            fontSize: textAdjust,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        onPress: () {
                          item['callback']();
                          if (isMenuVisible) _toggleMenu();
                        },
                        heightAdjust: rowHeightAdjust,
                      ),
                    );
                  }).toList(),
                ),
                const Spacer(),
                if (isCompact && !isMenuVisible)
                  _buildIconButton(Icons.menu, _toggleMenu),
                if (!isCompact) ...[
                  for (var item in widget.navItems)
                    Padding(
                      padding: const EdgeInsets.only(right: textSpacing),
                      child: _buildTextButton(item['title'], item['callback']),
                    ),
                  const SizedBox(width: iconSpacing),
                ],
              ],
            ),
          ).asGlass(),
        ),
        if (isMenuVisible)
          Align(
            alignment: Alignment.centerRight,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Container(
                width: 150,
                height: MediaQuery.of(context).size.height,
                //TODO 1: make the color of the banner and dropdown menu the same
                color: bannerColor.withOpacity(0.55),
                padding: EdgeInsets.fromLTRB(
                  16.0,
                  16 * columnHeightAdjust,
                  16.0,
                  16 * columnHeightAdjust,
                ),
                // This allows the buttons to truncate once the screen is shrinking past the point where all buttons fit.
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: textColor),
                        onPressed: _toggleMenu,
                      ),
                      SizedBox(
                        height: (textSpacing - 8) * columnHeightAdjust,
                      ),
                      //TODO: ensure all button sizes are consistent with the NavBar
                      for (var item in widget.navItems)
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: (textSpacing - 8) * columnHeightAdjust,
                          ),
                          child: _buildTextButton(item['title'], () {
                            item['callback']();
                            _toggleMenu();
                          }),
                        ),
                    ],
                  ),
                ),
              ).asGlass(),
            ),
          ),
      ],
    );
  }
}
