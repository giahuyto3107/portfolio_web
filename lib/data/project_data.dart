import 'package:portfolio_web/models/project.dart';

class ProjectData {
  static const List<Project> projects = [
    Project(
      title: 'TikTok Clone',
      description: 'A full-featured short video platform clone with video recording, editing, and sharing capabilities.',
      keyAchievement: 'Reduced image loading times by 40% using cached network images and lazy loading',
      techStack: ['Jetpack Compose', 'Firebase', 'FFmpeg', '', ''],
      githubUrl: 'https://github.com/your-username/tiktok-clone',
    ),
    Project(
      title: 'Automatic demonstration',
      description: 'A full-featured short video platform clone with video recording, editing, and sharing capabilities.',
      keyAchievement: 'Reduced image loading times by 40% using cached network images and lazy loading',
      techStack: ['Flutter', 'Firebase', 'FFmpeg', 'GetX'],
      githubUrl: 'https://github.com/your-username/tiktok-clone',
    ),
  ];

  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Core Mobile',
      icon: '📱',
      skills: [
        Skill(name: 'Flutter', category: 'Core Mobile'),
        Skill(name: 'Dart', category: 'Core Mobile'),
        Skill(name: 'Kotlin', category: 'Core Mobile'),
        Skill(name: 'Android SDK', category: 'Core Mobile'),
        Skill(name: 'Jetpack Compose', category: 'Core Mobile'),
      ],
    ),
    SkillCategory(
      title: 'Architecture',
      icon: '🏗️',
      skills: [
        Skill(name: 'MVVM', category: 'Architecture'),
        Skill(name: 'Clean Architecture', category: 'Architecture'),
        Skill(name: 'Riverpod Pattern', category: 'Architecture'),
        Skill(name: 'Repository Pattern', category: 'Architecture'),
      ],
    ),
    SkillCategory(
      title: 'Workflow',
      icon: '⚡',
      skills: [
        Skill(name: 'Git & GitHub', category: 'Workflow'),
        Skill(name: 'CI/CD', category: 'Workflow'),
        Skill(name: 'Firebase', category: 'Workflow'),
        Skill(name: 'REST APIs', category: 'Workflow'),
        Skill(name: 'Unit Testing', category: 'Workflow'),
        Skill(name: 'Agile/Scrum', category: 'Workflow'),
      ],
    ),
  ];
}
