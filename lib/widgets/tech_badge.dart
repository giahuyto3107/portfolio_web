import 'package:flutter/material.dart';
import 'package:portfolio_web/theme/app_theme.dart';

class TechBadge extends StatelessWidget {
  final String label;
  final Color? color;

  const TechBadge({
    super.key,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? _getColorForTech(label);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: badgeColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: badgeColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getColorForTech(String tech) {
    final colors = {
      'Flutter': const Color(0xFF02569B),
      'Dart': const Color(0xFF0175C2),
      'Kotlin': const Color(0xFF7F52FF),
      'Android': const Color(0xFF3DDC84),
      'Firebase': const Color(0xFFFFCA28),
      'Bloc': const Color(0xFF6366f1),
      'REST API': const Color(0xFF22c55e),
      'SQLite': const Color(0xFF003B57),
      'MVVM': const Color(0xFFec4899),
      'Retrofit': const Color(0xFF48B983),
      'GetX': const Color(0xFF8B5CF6),
      'FFmpeg': const Color(0xFF007808),
      'Room': const Color(0xFFB71C1C),
      'WebSocket': const Color(0xFFf97316),
      'Encryption': const Color(0xFF64748b),
      'Rive': const Color(0xFFFF6B6B),
      'Health Connect': const Color(0xFF4285F4),
      'Hive': const Color(0xFFF59E0B),
      'Provider': const Color(0xFF10B981),
      'Notifications': const Color(0xFFEF4444),
    };

    return colors[tech] ?? AppTheme.accentPrimary;
  }
}
