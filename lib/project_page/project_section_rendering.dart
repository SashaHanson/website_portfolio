import 'package:flutter/material.dart';
import '../NavBar/banner_widget.dart';
import '../home_page/home_screen.dart';
import '../portfolio_page/portfolio_screen.dart';
import '../copyright_notice.dart';
import 'project_title_page.dart';

//TODO: when the screen size shrinks the figures create rendering errors. Fix this
class ProjectSectionRendering extends StatefulWidget {
  final List<Widget> projectSections;
  final String title;

  const ProjectSectionRendering({
    required this.projectSections,
    required this.title,
    super.key,
  });

  @override
  State<ProjectSectionRendering> createState() =>
      _ProjectSectionRenderingState();
}

class _ProjectSectionRenderingState extends State<ProjectSectionRendering> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  // Function to scroll to a specific position
  void scrollToPosition(double position) {
    _scrollController.animateTo(
      position,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; // 892 for my screen
    double width = MediaQuery.of(context).size.width; // 1496 for my screen
    // Adjust height and width to allow for active resizing when the screen size changes
    double heightAdjust = (height / 892).clamp(0, 1.5);
    double widthAdjust = (width / 1496).clamp(0.4, 1.5);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ProjectTitlePage(
                      title: widget.title,
                    ),
                    Column(
                      children:
                          widget.projectSections.asMap().entries.map((entry) {
                        Widget widget = entry.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget,
                            const SizedBox(
                                height:
                                    10), // Add spacing between widgets if needed
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CopyrightNotice(width: width, widthAdjust: widthAdjust),
                  ],
                ),
              ),
            ],
          ),
          BannerWidget(
            logoItems: [
              {'title': 'Sasha Hanson', 'callback': () => scrollToPosition(0)},
            ],
            //TODO: possibly replace 'Back to Portfolio' button with just a back arrow
            navItems: [
              {
                'title': 'Back to Portfolio',
                'callback': () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PortfolioScreen(),
                      ),
                    );
                  });
                },
              },
              {
                'title': 'Home',
                'callback': () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  });
                },
              },
            ],
            heightAdjust: heightAdjust,
          ),
        ],
      ),
    );
  }
}
