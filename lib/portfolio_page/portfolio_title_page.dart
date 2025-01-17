import 'package:flutter/material.dart';
import '/constants.dart';

class PortfolioTitlePage extends StatefulWidget {
  final double height;
  final double width;
  final ScrollController scrollController;

  const PortfolioTitlePage({
    required this.height,
    required this.width,
    required this.scrollController,
    super.key,
  });

  @override
  State<PortfolioTitlePage> createState() => _PortfolioTitlePageState();
}

class _PortfolioTitlePageState extends State<PortfolioTitlePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Total cycle duration
    );

    // Create a sequence for still (2 seconds) and quick bounce (1 second)
    _bounceAnimation = TweenSequence([
      TweenSequenceItem(
        tween: ConstantTween(0.0), // Stay still
        weight: 2, // 2 seconds
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: -15.0).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 0.5, // Quick bounce up
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -15.0, end: 0.0).chain(
          CurveTween(curve: Curves.bounceOut),
        ),
        weight: 0.5, // Quick bounce down
      ),
    ]).animate(_animationController);

    // Repeat the animation
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Function to calculate dynamic font size based on screen height and width
  double _getResponsiveFontSize(double baseSize) {
    double scaleFactorH = (widget.height / 892).clamp(0.6, 1.1);
    double scaleFactorW = (widget.width / 1496).clamp(0.6, 1.1);
    return baseSize * scaleFactorH * scaleFactorW;
  }

  // Function to scroll to a specific position
  void scrollToPosition(double position) {
    widget.scrollController.animateTo(
      position,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double depTitleSize = _getResponsiveFontSize(titleSize);
    double widthAdjust = (widget.width / 1496).clamp(0.6, 1.1);
    double heightAdjust = (widget.height / 892).clamp(0.6, 1.1);

    return Stack(
      children: [
        // Background image
        Container(
          // Decide if title should be full screen size or half screen size
          height: widget.height, // * 0.80,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/shop_wallpaper_2k.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                color:
                    Colors.black.withOpacity(0.25), // Adjust opacity as needed
              ),
            ],
          ),
        ),

        // Text overlay
        Positioned.fill(
          child: Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              'PROJECTS',
              style: TextStyle(
                color: textColor,
                fontSize: depTitleSize,
                height: 0.9,
                fontFamily: 'Aldrich',
              ),
            ),
          ),
        ),
        // Arrow overlay
        Positioned(
          bottom: 10, // Align at the bottom
          left: 0,
          right: 0,
          child: Container(
            height: widget.height * 0.15,
            color: Colors
                .transparent, // Transparent background to overlay the image
            child: Center(
              child: AnimatedBuilder(
                animation: _bounceAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                        0, _bounceAnimation.value), // Animate up and down
                    //TODO: when the screen shrinks too much the arrow overlays with the body of the Portfolio page
                    child: IconButton(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 100,
                      color: Colors.white, // Adjust the color of the icon
                      onPressed: () {
                        scrollToPosition(
                            (widget.height * widthAdjust) - 60 * heightAdjust);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
