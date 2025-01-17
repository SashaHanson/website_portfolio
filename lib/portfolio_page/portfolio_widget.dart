import 'package:flutter/material.dart';
import 'package:website_portfolio/project_page/project_section_rendering.dart';

class PortfolioWidget extends StatefulWidget {
  //TODO: add the title section added to the variables passed
  final double left;
  final double right;
  final double? width;
  final String title;
  final String description;
  final String imageName;
  final List<Widget>
      projectSectionList; // Project sections passed as list to be rendered for the project screen as a scrollable column

  const PortfolioWidget({
    required this.left,
    required this.right,
    this.width,
    required this.title,
    required this.description,
    required this.imageName,
    required this.projectSectionList,
    super.key,
  });

  @override
  State<PortfolioWidget> createState() => _PortfolioWidgetState();
}

//TODO: ensure that the spacing between title and brief description is accurately calculated to ensure it is always the same spacing
class _PortfolioWidgetState extends State<PortfolioWidget> {
  bool isHovered = false;
  final GlobalKey _descriptionKey = GlobalKey();

  double _descriptionHeight = 0;

  // Measure the number of lines and height of the description
  void _calculateDescriptionMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          _descriptionKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      // Total height of the RenderBox
      _descriptionHeight = renderBox.size.height;

      setState(() {}); // Update UI after calculation
    });
  }

  // Getter to calculate the dynamic position of the title
  double get titlePosition {
    const double titleHeight = 24 * 1.2; // fontSize * lineHeight multiplier
    return _descriptionHeight + titleHeight; // Description height + gap
  }

  // Getter to calculate the dynamic position of the description
  double get descriptionPosition {
    return isHovered ? 20 : -(_descriptionHeight + 40); // Hover or off-screen
  }

  @override
  void initState() {
    super.initState();
    _calculateDescriptionMetrics();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = widget.width ??
        MediaQuery.of(context).size.width - widget.left - widget.right;

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectSectionRendering(
              projectSections: widget.projectSectionList,
              title: widget.title,
            ),
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: effectiveWidth,
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/${widget.imageName}'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              // Background fade effect
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: isHovered ? 0 : -100,
                left: 0,
                right: 0,
                height: isHovered ? 400 : 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Title
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: isHovered ? titlePosition : 20,
                left: 20,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'SpaceGrotesk',
                    height: 1.2, // Line height multiplier
                  ),
                ),
              ),
              // Description
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: isHovered ? descriptionPosition : -150,
                left: 20,
                right: 20,
                child: Text(
                  widget.description,
                  key:
                      _descriptionKey, // Assign the key to the description Text widget
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'SpaceGrotesk',
                    height: 1.5, // Consistent line height
                  ),
                ),
              ),
              // Blue border on top of the stack
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
