import 'package:flutter/material.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/constants/strings.dart';
import 'package:portfolio_web/widgets/animated_gradient_text.dart';
import 'package:portfolio_web/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onViewWorkPressed;

  const HeroSection({
    super.key,
    this.onViewWorkPressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _downloadResume() async {
    final Uri url = Uri.parse(AppLinks.resumeUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final screenHeight = context.screenHeight;

    return Container(
      constraints: BoxConstraints(minHeight: screenHeight * 0.9),
      padding: EdgeInsets.symmetric(
        horizontal: context.contentPadding,
        vertical: 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.maxContentWidth),
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Status badge
                  _buildStatusBadge(),
                  const SizedBox(height: 32),
                  // Main headline
                  _buildHeadline(isMobile),
                  const SizedBox(height: 24),
                  // Description
                  _buildDescription(isMobile),
                  const SizedBox(height: 48),
                  // CTA Buttons
                  _buildButtons(isMobile),
                  const SizedBox(height: 64),
                  // Scroll indicator
                  _buildScrollIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppTheme.successGreen,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.successGreen.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Open to opportunities',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(bool isMobile) {
    return Column(
      children: [
        Text(
          AppStrings.heroTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 40 : 64,
            fontWeight: FontWeight.w800,
            color: AppTheme.textPrimary,
            letterSpacing: -2,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedGradientText(
          text: AppStrings.heroSubtitle,
          style: TextStyle(
            fontSize: isMobile ? 40 : 64,
            fontWeight: FontWeight.w800,
            letterSpacing: -2,
            height: 1.1,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(bool isMobile) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 700),
      child: Text(
        AppStrings.heroDescription,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isMobile ? 16 : 18,
          color: AppTheme.textSecondary,
          height: 1.7,
        ),
      ),
    );
  }

  Widget _buildButtons(bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: AppStrings.viewWorkButton,
              onPressed: widget.onViewWorkPressed,
              icon: Icons.arrow_downward_rounded,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _downloadResume,
              icon: const Icon(Icons.download_rounded),
              label: const Text(AppStrings.downloadResumeButton),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PrimaryButton(
          label: AppStrings.viewWorkButton,
          onPressed: widget.onViewWorkPressed,
          icon: Icons.arrow_downward_rounded,
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: _downloadResume,
          icon: const Icon(Icons.download_rounded),
          label: const Text(AppStrings.downloadResumeButton),
        ),
      ],
    );
  }

  Widget _buildScrollIndicator() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Column(
            children: [
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppTheme.textMuted.withOpacity(0.5),
                size: 32,
              ),
            ],
          ),
        );
      },
    );
  }
}
