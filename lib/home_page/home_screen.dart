import 'package:flutter/material.dart';
import 'package:website_portfolio/constants.dart';
import '../portfolio_page/portfolio_screen.dart';
import 'home_title_page.dart';
import 'section_widget.dart';
import '../NavBar/banner_widget.dart';
import 'package:website_portfolio/copyright_notice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO: refactor this entire website to improve performance
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _isHovered = false; // Track hover state

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

  // Launches outlook to send email to me
  void openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'sasha.hanson1@outlook.com',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email client';
    }
  }

  void openLinkedIn() async {
    final Uri websiteUri = Uri.parse(
        'https://www.linkedin.com/in/sasha-difelice-hanson-292844252/'); // Replace with your URL

    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri);
    } else {
      throw 'Could not open the website';
    }
  }

  //TODO: this is my school github account there are more available projects here than on my personal. When my person has more on it switch the link to my personal Github in place of my school.
  void openGithub() async {
    final Uri websiteUri = Uri.parse(
        'https://github.com/SashaHanson1?tab=repositories'); // Replace with your URL

    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri);
    } else {
      throw 'Could not open the website';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; // 892 for my screen
    double width = MediaQuery.of(context).size.width; // 1496 for my screen
    // Adjust height and width to allow for active resizing when the screen size changes
    double heightAdjustment = (height / 892).clamp(0, 1.5);
    double widthAdjustment = (width / 1496).clamp(0.3, 1.5);

    //define all sections here so the height getter may be used for NavBar coordinates
    SectionWidget aboutSection = SectionWidget(
      screenWidth: width,
      padding: const EdgeInsets.fromLTRB(
            100,
            130,
            300,
            30,
          ) *
          widthAdjustment,
      title: 'About Me',
      titleAlignment: AlignmentDirectional.bottomStart,
      textItems: const [
        {
          'text':
              'I am a passionate and dedicated student at the University of Western Ontario, currently completing my 3rd year of my 5 year dual degree in Mechatronics & A.I. Systems Engineering. I thoroughly enjoy working on projects that will expand my engineering knowledge and hands-on experience in mechanics, robotics, and programming applications, but I will take any opportunity to expand those horizons as well. I am an active participant in multiple university mega projects, where we exercise our creativity, leadership skills, as well as our analytical and innovative thinking skills.',
          'alignment': AlignmentDirectional.bottomStart,
          'textAlign': TextAlign.left,
        },
      ],
      isBubble: true,
    );

    SectionWidget skillsSection = SectionWidget(
      screenWidth: width,
      padding: EdgeInsets.fromLTRB(
        270 * widthAdjustment,
        100 * widthAdjustment,
        100 * widthAdjustment,
        130 * widthAdjustment,
      ),
      title: 'Skills',
      titleAlignment: AlignmentDirectional.bottomEnd,
      textItems: const [
        {
          //quick intro to skills
          'text':
              'Here\'s a quick look at some of my most relevant engineering skills in programming, robotics, and mechanics:\n',
          'alignment': Alignment.bottomRight, //Directional.bottomEnd,
          'textAlign': TextAlign.right,
        },
        {
          // skills headers
          'texts': [
            'Computer programming\nlanguages:\n',
            'Robotics and\nMicrocontrollers:\n',
            'Engineering Software\nApplications:\n',
          ],
          'alignment': [
            Alignment.centerLeft,
            Alignment.center,
            Alignment.centerRight,
          ],
          'textAlign': TextAlign.center,
        },
        {
          // list of skills
          'texts': [
            '• Python \n• Java \n• JavaScript \n• C \n• C++ \n• C# \n• Arduino \n• HTML \n• Flutter',
            '• Arduino \n• ESP32 \n• Raspberry Pi',
            '• SOLIDWORKS \n• Altium \n• OnShape \n• VS Code & other IDEs \n• Office 365 \n• G-Suite',
          ],
          'alignment': AlignmentDirectional.centerStart,
          'textAlign': TextAlign.center,
        },
      ],
      isBubble: true,
    );

    SectionWidget portfolioSection = SectionWidget(
      screenWidth: width,
      padding: EdgeInsets.fromLTRB(
        width * widthAdjustment.clamp(0.7, 1) / 1.4,
        130 * (widthAdjustment.clamp(1, 1.5)),
        90 * widthAdjustment,
        0,
      ),
      title: 'Portfolio',
      titleAlignment: AlignmentDirectional.bottomCenter,
      textItems: const [
        {
          'text':
              'Between my schooling, clubs, and work experience, I have had the pleasure of working on a number of personal engineering projects across various disciplines. Here is one of my favourites: A Go-Kart made from broken or scrap components in an effort to challenge myself on a cheap budget (Replace this image with a Picture of my Go-Kart). This is only the tip of the iceberg, to see more of what I\'ve made, click the \'More Info\' below and take a look!',
          'alignment': AlignmentDirectional.bottomCenter,
          'textAlign': TextAlign.left,
        },
      ],
      isBubble: false,
    );

    SectionWidget contactSection = SectionWidget(
      screenWidth: width,
      padding: EdgeInsets.fromLTRB(
        100 * widthAdjustment,
        150 * widthAdjustment,
        300 * widthAdjustment,
        150 * widthAdjustment,
      ),
      title: 'Contact',
      titleAlignment: AlignmentDirectional.bottomStart,
      textItems: const [
        {
          'text':
              'If you have any questions, comments, or just want to learn more about me and what I do, shoot me an email or check out my LinkedIn and GitHub here:',
          'alignment': AlignmentDirectional.bottomStart,
          'textAlign': TextAlign.left,
        },
      ],
      iconButtons: [
        IconButton(
          icon: const Icon(
            Icons.mail,
            size: 30,
          ),
          onPressed: () {
            openEmail();
          }, // Replace with button functionality
          color: Colors.white,
        ),
        IconButton(
          icon: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 30, // Smaller width than the icon
                height: 30, // Smaller height than the icon
                color: Colors.transparent, // White background
              ),
              Container(
                width: 20, // Smaller width than the icon
                height: 20, // Smaller height than the icon
                color: Colors.white, // White background
              ),
              const FaIcon(
                FontAwesomeIcons.linkedin,
                color: linkedInColor, // LinkedIn blue
                size: 30, // Icon size
              ),
            ],
          ), //FaIcon(FontAwesomeIcons.linkedin),
          onPressed: () {
            openLinkedIn();
          }, // Replace with button functionality
          //color: Color(0xFF0A66C2), //LinkedIn blue
        ),
        IconButton(
          icon: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 30, // Smaller width than the icon
                height: 28, // Smaller height than the icon
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const FaIcon(
                FontAwesomeIcons.github,
                color: Colors.black, // LinkedIn blue
                size: 31, // Icon size
              ),
            ],
          ),
          //FaIcon(FontAwesomeIcons.linkedin),
          onPressed: () {
            openGithub();
          }, // Replace with button functionality
          //color: Colors.white, //LinkedIn blue
        ),
      ],
      isBubble: true,
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    HomeTitlePage(height: height, width: width),
                    aboutSection,
                    skillsSection,
                    Stack(
                      children: <Widget>[
                        Material(
                          elevation: 5,
                          child: SizedBox(
                            height: height,
                            width: width,
                            child: Image.asset(
                              'images/robotic_arms_2k.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: height, // Define height
                          width: width, // Define width
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.5),
                                Colors.black
                              ],
                              stops: const [0.0, 0.4, 1],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                        portfolioSection,

                        // More Info Button
                        Padding(
                          padding: EdgeInsets.only(
                              left:
                                  width * widthAdjustment.clamp(0.7, 1) / 1.55,
                              top: height * 0.8),
                          child: Container(
                            alignment: Alignment.center,
                            child: MouseRegion(
                              onEnter: (_) {
                                setState(() {
                                  _isHovered = true;
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  _isHovered = false;
                                });
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    // Saves on memory but has longer loading times compared to push/pop
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PortfolioScreen(),
                                    ),
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'More Info',
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 25 *
                                                widthAdjustment.clamp(
                                                    0.75, 1.5),
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Icon(Icons.east),
                                      ],
                                    ),
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                      margin: const EdgeInsets.only(top: 4),
                                      height: 2,
                                      width: _isHovered
                                          ? 90
                                          : 0, // Expand width on hover
                                      color: textColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    contactSection,
                    CopyrightNotice(width: width, widthAdjust: widthAdjustment),
                  ],
                ),
              ),
            ],
          ),
          BannerWidget(
            logoItems: [
              {'title': 'Sasha Hanson', 'callback': () => scrollToPosition(0)},
            ],
            navItems: [
              {
                'title': 'About',
                'callback': () =>
                    scrollToPosition(height - (68 * heightAdjustment)),
                //'isVisible': true
              },
              {
                'title': 'Skills',
                'callback': () => scrollToPosition(height +
                    (115 * widthAdjustment) -
                    (68 * heightAdjustment) +
                    aboutSection.sectionHeight),
                //'isVisible': true
              },
              {
                'title': 'Portfolio',
                'callback': () => scrollToPosition(height * heightAdjustment +
                    (360 * (width / 1496).clamp(0.369, 1.5)) +
                    aboutSection.sectionHeight +
                    skillsSection.sectionHeight),
                //'isVisible': false
              }, // Hidden from navbar
              {
                'title': 'Contact',
                'callback': () => scrollToPosition(
                    _scrollController.position.maxScrollExtent),
                //'isVisible': true
              },
            ],
            heightAdjust: heightAdjustment,
          ),
        ],
      ),
    );
  }
}
