import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactFooter extends StatelessWidget {
  const ContactFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.contentPadding,
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        gradient: AppTheme.subtleGradient,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.maxContentWidth),
          child: Column(
            children: [
              // Contact section
              _buildContactSection(isMobile),
              const SizedBox(height: 64),
              // Divider
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppTheme.borderColor,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Footer credits
              _buildFooterCredits(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection(bool isMobile) {
    return Column(
      children: [
        // Heading
        const Text(
          AppStrings.contactTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          AppStrings.contactSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 40),
        // Social links
        if (isMobile)
          Column(
            children: [
              _SocialButton(
                icon: FontAwesomeIcons.linkedin,
                label: 'LinkedIn',
                url: AppLinks.linkedinUrl,
                color: const Color(0xFF0A66C2),
              ),
              const SizedBox(height: 16),
              _SocialButton(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                url: AppLinks.githubUrl,
                color: const Color(0xFFf0f6fc),
              ),
              const SizedBox(height: 16),
              _SocialButton(
                icon: FontAwesomeIcons.envelope,
                label: 'Email',
                url: 'mailto:${AppLinks.emailAddress}',
                color: const Color(0xFFea4335),
              ),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialButton(
                icon: FontAwesomeIcons.linkedin,
                label: 'LinkedIn',
                url: AppLinks.linkedinUrl,
                color: const Color(0xFF0A66C2),
              ),
              const SizedBox(width: 20),
              _SocialButton(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                url: AppLinks.githubUrl,
                color: const Color(0xFFf0f6fc),
              ),
              const SizedBox(width: 20),
              _SocialButton(
                icon: FontAwesomeIcons.envelope,
                label: 'Email',
                url: 'mailto:${AppLinks.emailAddress}',
                color: const Color(0xFFea4335),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildFooterCredits(bool isMobile) {
    return Column(
      children: [
        // Built with Flutter badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppTheme.borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlutterLogo(size: 20),
              const SizedBox(width: 10),
              const Text(
                AppStrings.builtWithFlutter,
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Copyright
        Text(
          AppStrings.copyrightText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: AppTheme.textMuted,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color color;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withOpacity(0.15)
                : AppTheme.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? widget.color.withOpacity(0.5)
                  : AppTheme.borderColor,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                color: _isHovered ? widget.color : AppTheme.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered ? widget.color : AppTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
