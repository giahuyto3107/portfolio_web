import 'package:flutter/material.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/constants/strings.dart';
import 'package:portfolio_web/data/project_data.dart';
import 'package:portfolio_web/widgets/section_header.dart';

class TechnicalToolkitSection extends StatelessWidget {
  const TechnicalToolkitSection({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: AppStrings.technicalToolkitTitle,
                subtitle: AppStrings.technicalToolkitSubtitle,
              ),
              const SizedBox(height: 48),
              if (isMobile)
                _buildMobileLayout()
              else
                _buildDesktopLayout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    final categories = ProjectData.skillCategories;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _SkillCategoryCard(category: categories[0])),
        const SizedBox(width: 24),
        Expanded(child: _SkillCategoryCard(category: categories[1])),
        const SizedBox(width: 24),
        Expanded(child: _SkillCategoryCard(category: categories[2])),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: ProjectData.skillCategories
          .map((category) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _SkillCategoryCard(category: category),
              ))
          .toList(),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final dynamic category;

  const _SkillCategoryCard({required this.category});

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;

  Color _getCategoryColor() {
    switch (widget.category.title) {
      case 'Core Mobile':
        return const Color(0xFF3b82f6);
      case 'Architecture':
        return const Color(0xFF8b5cf6);
      case 'Workflow':
        return const Color(0xFF22c55e);
      default:
        return AppTheme.accentPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: AppTheme.cardRadius,
          border: Border.all(
            color: _isHovered ? color.withOpacity(0.5) : AppTheme.borderColor,
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ]
              : AppTheme.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      widget.category.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  widget.category.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Skills grid
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widget.category.skills.map<Widget>((skill) {
                return _SkillChip(
                  name: skill.name,
                  color: color,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String name;
  final Color color;

  const _SkillChip({
    required this.name,
    required this.color,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.color.withOpacity(0.2)
              : AppTheme.secondaryBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered
                ? widget.color.withOpacity(0.5)
                : AppTheme.borderColor.withOpacity(0.5),
          ),
        ),
        child: Text(
          widget.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _isHovered ? widget.color : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
