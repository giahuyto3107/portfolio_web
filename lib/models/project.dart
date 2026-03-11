class Project {
  final String title;
  final String description;
  final String keyAchievement;
  final List<String> techStack;
  final String? imageUrl;
  final String? githubUrl;
  final String? liveUrl;
  final bool isFeatured;

  const Project({
    required this.title,
    required this.description,
    required this.keyAchievement,
    required this.techStack,
    this.imageUrl,
    this.githubUrl,
    this.liveUrl,
    this.isFeatured = false,
  });
}

class Skill {
  final String name;
  final String? iconPath;
  final String category;

  const Skill({
    required this.name,
    this.iconPath,
    required this.category,
  });
}

class SkillCategory {
  final String title;
  final String icon;
  final List<Skill> skills;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}
