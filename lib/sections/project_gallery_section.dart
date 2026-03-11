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
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    int crossAxisCount = 3;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.contentPadding,
        vertical: 80,
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
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: isMobile ? 1.1 : 0.95,
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
