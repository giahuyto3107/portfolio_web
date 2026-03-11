import 'package:flutter/material.dart';
import 'package:portfolio_web/models/project.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/widgets/tech_badge.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Future<void> _openProject() async {
    if (widget.project.githubUrl != null) {
      final uri = Uri.parse(widget.project.githubUrl!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }

  // Project thumbnail icon based on index
  IconData _getProjectIcon() {
    final icons = [
      Icons.play_circle_filled_rounded,
      Icons.shopping_bag_rounded,
      Icons.fitness_center_rounded,
      Icons.chat_bubble_rounded,
      Icons.cloud_rounded,
      Icons.check_circle_rounded,
    ];
    return icons[widget.index % icons.length];
  }

  // Gradient colors for each project
  List<Color> _getProjectGradient() {
    final gradients = [
      [const Color(0xFFFF0050), const Color(0xFFFF4081)],
      [const Color(0xFF6366f1), const Color(0xFF8b5cf6)],
      [const Color(0xFF22c55e), const Color(0xFF16a34a)],
      [const Color(0xFF3b82f6), const Color(0xFF1d4ed8)],
      [const Color(0xFFf59e0b), const Color(0xFFd97706)],
      [const Color(0xFFec4899), const Color(0xFFbe185d)],
    ];
    return gradients[widget.index % gradients.length];
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _getProjectGradient();
    final screenWidth = context.screenWidth;

    // More granular responsive sizing based on screen width
    final bool isCompact = screenWidth < 600;
    final bool isMedium = screenWidth >= 600 && screenWidth < 1150;

    final thumbnailHeight = isCompact ? 90.0 : (isMedium ? 100.0 : 120.0);
    final contentPadding = isCompact ? 12.0 : (isMedium ? 14.0 : 18.0);
    final titleFontSize = isCompact ? 14.0 : (isMedium ? 15.0 : 17.0);
    final descriptionFontSize = isCompact ? 12.0 : (isMedium ? 12.0 : 13.0);
    final linkFontSize = isCompact ? 11.0 : (isMedium ? 11.0 : 12.0);
    final projectIconSize = isCompact ? 32.0 : (isMedium ? 38.0 : 44.0);
    final linkIconSize = isCompact ? 14.0 : (isMedium ? 15.0 : 16.0);
    final arrowIconSize = isCompact ? 13.0 : (isMedium ? 14.0 : 15.0);
    final footerVerticalPadding = isCompact ? 8.0 : (isMedium ? 10.0 : 12.0);
    final badgeSpacing = isCompact ? 4.0 : 5.0;
    final maxBadges = isCompact ? 2 : 3;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: _openProject,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: AppTheme.cardBg,
                  borderRadius: AppTheme.cardRadius,
                  border: Border.all(
                    color: _isHovered
                        ? gradient[0].withOpacity(0.5)
                        : AppTheme.borderColor,
                    width: 1.5,
                  ),
                  boxShadow: _isHovered
                    ? [
                      BoxShadow(
                        color: gradient[0].withOpacity(0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : AppTheme.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project thumbnail/icon area
                    Container(
                      width: double.infinity,
                      height: thumbnailHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          _getProjectIcon(),
                          color: Colors.white.withOpacity(0.9),
                          size: projectIconSize,
                        ),
                      ),
                    ),
                    // Content
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(contentPadding),
                        child: ClipRect(
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                widget.project.title,
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              // Key achievement
                              Expanded(
                                child: Text(
                                  widget.project.keyAchievement,
                                  style: TextStyle(
                                    fontSize: descriptionFontSize,
                                    color: AppTheme.textSecondary,
                                    height: 1.4,
                                  ),
                                  maxLines: isCompact ? 2 : 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 6),
                              // Tech stack badges
                              Flexible(
                                child: ClipRect(
                                  child: Wrap(
                                    spacing: badgeSpacing,
                                    runSpacing: badgeSpacing,
                                    children: widget.project.techStack
                                        .take(maxBadges)
                                        .map((tech) => TechBadge(
                                            label: tech,
                                            isCompact: isCompact || isMedium,
                                          ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // View project link
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: contentPadding,
                        vertical: footerVerticalPadding,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppTheme.borderColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.code_rounded,
                            size: linkIconSize,
                            color: _isHovered
                                ? gradient[0]
                                : AppTheme.textMuted,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'View on GitHub',
                            style: TextStyle(
                              fontSize: linkFontSize,
                              fontWeight: FontWeight.w500,
                              color: _isHovered
                                  ? gradient[0]
                                  : AppTheme.textMuted,
                            ),
                          ),
                          const Spacer(),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            transform: Matrix4.translationValues(
                              _isHovered ? 4 : 0,
                              0,
                              0,
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: arrowIconSize,
                              color: _isHovered
                                  ? gradient[0]
                                  : AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
