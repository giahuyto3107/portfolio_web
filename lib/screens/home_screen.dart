import 'package:flutter/material.dart';
import 'package:portfolio_web/sections/hero_section.dart';
import 'package:portfolio_web/sections/featured_project_section.dart';
import 'package:portfolio_web/sections/project_gallery_section.dart';
import 'package:portfolio_web/sections/technical_toolkit_section.dart';
import 'package:portfolio_web/sections/about_section.dart';
import 'package:portfolio_web/sections/contact_footer.dart';
import 'package:portfolio_web/widgets/navigation_bar.dart';
import 'package:portfolio_web/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  
  // Section keys for navigation
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBg,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primaryBg,
                  Color(0xFF0d0d14),
                  AppTheme.primaryBg,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
          // Main content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    HeroSection(
                      key: _heroKey,
                      onViewWorkPressed: () => _scrollToSection(_projectsKey),
                    ),
                    FeaturedProjectSection(key: _projectsKey),
                    const ProjectGallerySection(),
                    TechnicalToolkitSection(key: _skillsKey),
                    AboutSection(key: _aboutKey),
                    ContactFooter(key: _contactKey),
                  ],
                ),
              ),
            ],
          ),
          // Floating navigation
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNavigationBar(
              onHomePressed: () => _scrollToSection(_heroKey),
              onProjectsPressed: () => _scrollToSection(_projectsKey),
              onSkillsPressed: () => _scrollToSection(_skillsKey),
              onAboutPressed: () => _scrollToSection(_aboutKey),
              onContactPressed: () => _scrollToSection(_contactKey),
            ),
          ),
        ],
      ),
    );
  }
}
