import 'package:flutter/material.dart';
import '../portfolio_page/portfolio_title_page.dart';
import '../home_page/home_screen.dart';
import '../NavBar/banner_widget.dart';
import '../copyright_notice.dart';
import '../project_page/project_section.dart';
import 'portfolio_widget.dart';

// TODO: Alter the code to shrink the widget sizes to a point and then begin to cut them off
class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Adjust height and width to allow for active resizing when the screen size changes
    double heightAdjustment = (height / 892).clamp(0, 1.5);
    double widthAdjustment = (width / 1496).clamp(0.5, 1.5);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    PortfolioTitlePage(
                      height: height,
                      width: width,
                      scrollController: _scrollController,
                    ),

                    //TODO: Alter these buttons to, upon selecting one, the visible grid items are refined to only show the items containing the tag associated with each button (e.g. if mechanical is selected, only show mechanical projects). Note: delete the sized box below upon adding the buttons back in.
                    //The following code section will only be added once there are plenty more projects that refinement is required
                    /*
                    // Row of refinement buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Wrap(
                        spacing: 8, // Space between buttons horizontally
                        runSpacing:
                            10, // Space between rows of buttons vertically
                        alignment: WrapAlignment
                            .center, // Align the buttons in the center
                        children: /*Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: */
                            [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Mechanical"),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Electrical"),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Software"),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Mechatronics"),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Misc."),
                          ),
                        ],
                      ),
                    ),*/

                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 100 * widthAdjustment),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Line: Small and Large Widget
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: ((width / 2) - (100 * widthAdjustment) - 5)
                                  .clamp(514.3,
                                      1000), // Technically there should not be any upper limit
                              child: const PortfolioWidget(
                                left: 10,
                                right: 10,
                                title: 'Self Watering Planter',
                                description:
                                    'This project is a work in progress. The concept is to design a planter that provides advanced functionality to ensure plant health while maintaining a sleek look with electronics hidden.',
                                imageName: 'gradient_background.jpg',

                                //TODO: the long description from each section should be saved as a .txt file and pulled on rather than having an entire essay in the code
                                projectSectionList: [
                                  ProjectSection(
                                    title: 'Coming Soon',
                                    description: '...in the near future.',
                                  ),
                                  ProjectSection(
                                    title: 'But maybe sooner',
                                    description: '...in the NEARER future.',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10), // Spacing
                            SizedBox(
                              width: ((width / 2) - (100 * widthAdjustment) - 5)
                                  .clamp(514.3, 1000), // Explicit width
                              child: const PortfolioWidget(
                                left: 10,
                                right: 10,
                                title: 'Go-Kart',
                                description:
                                    'One of my very first projects and quite the learning curve! Made mostly from broken and scrap parts, this project was challenging and lots of fun, and its fast!',
                                imageName: 'go_kart.jpg',
                                //TODO: the variable completeProjectScreen needs to be a list of ProjectScreen() calls so that multiple subsections can all be added dynamically to allow for a comprehensive report of each project
                                projectSectionList: [
                                  ProjectSection(
                                    //TODO: the title and the title page need to be brought out of ProjectScreen and should be a call of their own within PortfolioWidget()
                                    title: 'Mechanics',
                                    description:
                                        'Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! Electronics are awesome! ',
                                    imageItems: [
                                      {
                                        'image': 'go_kart.jpg',
                                        'width': 120.0,
                                        'height': 100.0,
                                        'figureTextPosition': 'above',
                                        'description':
                                            'A detailed view of the circuit board.',
                                        'padding':
                                            EdgeInsets.fromLTRB(10, 20, 10, 20),
                                      },
                                      {
                                        'image': 'go_kart.jpg',
                                        'width': 150.0,
                                        'height': 150.0,
                                        'figureTextPosition': 'beside',
                                        'besidePosition':
                                            'left', // Figure text to the left
                                        'description':
                                            'Side view of the assembled components.',
                                        'padding': EdgeInsets.all(15),
                                      },
                                      {
                                        'image': 'go_kart.jpg',
                                        'width': 200.0,
                                        'height': 200.0,
                                        'figureTextPosition': 'beside',
                                        'besidePosition':
                                            'right', // Figure text to the right
                                        'description':
                                            'Close-up of soldering points.',
                                        'padding': EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                      },
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10), // Spacing between rows
                      // Second Line: Three Widgets (Widget 3 is double the size of Widget 1 and 2)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: ((width * 0.36) -
                                      ((200 * widthAdjustment) + 20) / 3)
                                  .clamp(363.6 - (20 / 3),
                                      727.2 - (20 / 3)), // Explicit width
                              child: const PortfolioWidget(
                                left: 10,
                                right: 10,
                                title: 'FPV Drone',
                                description:
                                    'This First Person Viewing (FPV) drone was built from the ground up, utilizing skills in 3D modelling, circuit and PCB design, programming, and more.',
                                imageName: 'gradient_background.jpg',
                                projectSectionList: [
                                  ProjectSection(
                                    title: 'Coming Soon',
                                    description: '...in the near future.',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10), // Spacing
                            SizedBox(
                              width: ((width * 0.28) -
                                      ((200 * widthAdjustment) + 20) / 3)
                                  .clamp(282.8 - (20 / 3),
                                      565.6 - (20 / 3)), // Explicit width
                              child: const PortfolioWidget(
                                left: 10,
                                right: 10,
                                title: 'Website Portfolio',
                                description:
                                    'Made entirely using Googles front end programming language Flutter, this was made with the sole purpose of showcasing the many projects I\'ve worked on.',
                                imageName: 'gradient_background.jpg',
                                projectSectionList: [
                                  ProjectSection(
                                    title: 'Coming Soon',
                                    description: '...in the near future.',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10), // Spacing
                            SizedBox(
                              width: ((width * 0.36) -
                                      ((200 * widthAdjustment) + 20) / 3)
                                  .clamp(363.6 - (20 / 3),
                                      727.2 - (20 / 3)), // Explicit width
                              child: const PortfolioWidget(
                                left: 10,
                                right: 10,
                                title: 'Autonomous Lawn Mower',
                                description:
                                    'In an attempt to improve lawn care precision and efficiency, this design aims to replace a push mower with an autonomous one capable of cutting the lawn in the same time frame (~20min)',
                                imageName: 'gradient_background.jpg',
                                projectSectionList: [
                                  ProjectSection(
                                    title: 'Coming Soon',
                                    description: '...in the near future.',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10), // Spacing between rows
                      // Third Line: Single Widget
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: (width - (200 * widthAdjustment))
                              .clamp(1038, 2500), // Take up the entire line
                          child: const PortfolioWidget(
                            left: 10,
                            right: 10,
                            title: 'Weather Forecast Machine Learning Model',
                            description:
                                'This ML model allows me to apply and experiment with the knowledge I am being taught in my Artificial Intelligence Systems Engineering dual degree.',
                            imageName: 'gradient_background.jpg',
                            projectSectionList: [
                              ProjectSection(
                                title: 'Coming Soon',
                                description: '...in the near future.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    CopyrightNotice(width: width, widthAdjust: widthAdjustment),
                  ],
                ),
              ),
            ],
          ),
          BannerWidget(
            logoItems: [
              {
                'title': 'Sasha D. Hanson',
                'callback': () => scrollToPosition(0)
              },
            ],
            navItems: [
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
            heightAdjust: heightAdjustment,
          ),
        ],
      ),
    );
  }
}
