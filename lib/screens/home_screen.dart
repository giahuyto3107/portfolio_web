import 'package:flutter/material.dart';
import 'package:portfolio_web/sections/hero_section.dart';
import 'package:portfolio_web/sections/featured_project_section.dart';
import 'package:portfolio_web/sections/project_gallery_section.dart';
import 'package:portfolio_web/sections/technical_toolkit_section.dart';
import 'package:portfolio_web/sections/about_section.dart';
import 'package:portfolio_web/sections/mobile_portfolio_section.dart';
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
  bool _showScrollToTop = false;
  
  // Section keys for navigation
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final showButton = _scrollController.offset > 300;
    if (showButton != _showScrollToTop) {
      setState(() => _showScrollToTop = showButton);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
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
                    // Navigation bar (now scrollable)
                    CustomNavigationBar(
                      onHomePressed: () => _scrollToTop(),
                      onProjectsPressed: () => _scrollToSection(_projectsKey),
                      onSkillsPressed: () => _scrollToSection(_skillsKey),
                      onAboutPressed: () => _scrollToSection(_aboutKey),
                      onContactPressed: () => _scrollToSection(_contactKey),
                    ),
                    HeroSection(
                      key: _heroKey,
                      onViewWorkPressed: () => _scrollToSection(_projectsKey),
                    ),
                    FeaturedProjectSection(key: _projectsKey),
                    const ProjectGallerySection(),
                    TechnicalToolkitSection(key: _skillsKey),
                    AboutSection(key: _aboutKey),
                    const MobilePortfolioSection(),
                    ContactFooter(key: _contactKey),
                  ],
                ),
              ),
            ],
          ),
          // Scroll to top button
          Positioned(
            bottom: 32,
            right: 32,
            child: AnimatedOpacity(
              opacity: _showScrollToTop ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: AnimatedScale(
                scale: _showScrollToTop ? 1.0 : 0.8,
                duration: const Duration(milliseconds: 300),
                child: IgnorePointer(
                  ignoring: !_showScrollToTop,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _scrollToTop,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.accentPrimary.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
