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
                      height: 120,
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
                          size: 48,
                        ),
                      ),
                    ),
                    // Content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              widget.project.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Key achievement
                            Expanded(
                              child: Text(
                                widget.project.keyAchievement,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.textSecondary,
                                  height: 1.5,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Tech stack badges
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: widget.project.techStack
                                  .take(3)
                                  .map((tech) => TechBadge(label: tech))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // View project link
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
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
                            size: 18,
                            color: _isHovered
                                ? gradient[0]
                                : AppTheme.textMuted,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'View on GitHub',
                            style: TextStyle(
                              fontSize: 13,
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
                              size: 16,
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
