import 'package:flutter/material.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/constants/strings.dart';
import 'package:portfolio_web/data/project_data.dart';
import 'package:portfolio_web/widgets/section_header.dart';
import 'package:portfolio_web/widgets/project_card.dart';

class ProjectGallerySection extends StatelessWidget {
  const ProjectGallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final isMobile = context.isMobile;

    // More granular breakpoints for column count
    int crossAxisCount;
    double childAspectRatio;
    double spacing;

    if (screenWidth < 600) {
      // Mobile: 1 column
      crossAxisCount = 1;
      childAspectRatio = 1.3;
      spacing = 20;
    } else if (screenWidth < 900) {
      // Small tablet: 2 columns
      crossAxisCount = 2;
      childAspectRatio = 0.85;
      spacing = 20;
    } else if (screenWidth < 1150) {
      // Large tablet / small desktop: 2 columns with better ratio
      crossAxisCount = 2;
      childAspectRatio = 1.0;
      spacing = 24;
    } else {
      // Desktop: 3 columns
      crossAxisCount = 3;
      childAspectRatio = 0.9;
      spacing = 24;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.contentPadding,
        vertical: isMobile ? 60 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: AppStrings.projectGalleryTitle,
                subtitle: AppStrings.projectGallerySubtitle,
              ),
              const SizedBox(height: 48),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: ProjectData.projects.length,
                itemBuilder: (context, index) {
                  final project = ProjectData.projects[index];
                  return ProjectCard(
                    project: project,
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
