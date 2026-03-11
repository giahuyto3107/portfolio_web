import 'package:flutter/material.dart';
import 'package:portfolio_web/theme/app_theme.dart';

class CustomNavigationBar extends StatefulWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onProjectsPressed;
  final VoidCallback onSkillsPressed;
  final VoidCallback onAboutPressed;
  final VoidCallback onContactPressed;

  const CustomNavigationBar({
    super.key,
    required this.onHomePressed,
    required this.onProjectsPressed,
    required this.onSkillsPressed,
    required this.onAboutPressed,
    required this.onContactPressed,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    // Listen to scroll position would require a different approach
    // For now, we'll use a simpler hover state
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: context.contentPadding,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: _isScrolled 
            ? AppTheme.primaryBg.withOpacity(0.95) 
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled ? AppTheme.borderColor : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.onHomePressed,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'H',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (!isMobile) ...[
                    const SizedBox(width: 12),
                    const Text(
                      'To Gia Huy (Harry)',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Navigation items
          if (isMobile)
            _buildMobileMenu()
          else
            _buildDesktopNav(),
        ],
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      children: [
        _NavItem(label: 'Home', onTap: widget.onHomePressed),
        _NavItem(label: 'Projects', onTap: widget.onProjectsPressed),
        _NavItem(label: 'Skills', onTap: widget.onSkillsPressed),
        _NavItem(label: 'About', onTap: widget.onAboutPressed),
        const SizedBox(width: 16),
        _buildContactButton(),
      ],
    );
  }

  Widget _buildMobileMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: AppTheme.textPrimary),
      color: AppTheme.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onSelected: (value) {
        switch (value) {
          case 'home':
            widget.onHomePressed();
            break;
          case 'projects':
            widget.onProjectsPressed();
            break;
          case 'skills':
            widget.onSkillsPressed();
            break;
          case 'about':
            widget.onAboutPressed();
            break;
          case 'contact':
            widget.onContactPressed();
            break;
        }
      },
      itemBuilder: (context) => [
        _buildMenuItem('Home', 'home'),
        _buildMenuItem('Projects', 'projects'),
        _buildMenuItem('Skills', 'skills'),
        _buildMenuItem('About', 'about'),
        _buildMenuItem('Contact', 'contact'),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(String label, String value) {
    return PopupMenuItem(
      value: value,
      child: Text(
        label,
        style: const TextStyle(color: AppTheme.textPrimary),
      ),
    );
  }

  Widget _buildContactButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onContactPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: AppTheme.buttonRadius,
            boxShadow: [
              BoxShadow(
                color: AppTheme.accentPrimary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Text(
            'Contact Me',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: _isHovered ? AppTheme.accentPrimary : AppTheme.textSecondary,
              fontSize: 15,
              fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
