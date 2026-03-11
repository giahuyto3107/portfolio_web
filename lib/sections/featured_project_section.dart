import 'package:flutter/material.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/constants/strings.dart';
import 'package:portfolio_web/widgets/section_header.dart';
import 'package:portfolio_web/widgets/tech_badge.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturedProjectSection extends StatelessWidget {
  const FeaturedProjectSection({super.key});

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
                title: AppStrings.featuredProjectTitle,
                subtitle: 'My flagship mobile application',
              ),
              const SizedBox(height: 48),
              if (isMobile)
                _buildMobileLayout(context)
              else
                _buildDesktopLayout(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: AppTheme.cardRadius,
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Project details
          Expanded(
            flex: 3,
            child: _buildProjectDetails(),
          ),
          const SizedBox(width: 48),
          // Right side - QR Code and actions
          Expanded(
            flex: 2,
            child: _buildQRSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: AppTheme.cardRadius,
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProjectDetails(),
          const SizedBox(height: 32),
          _buildQRSection(),
        ],
      ),
    );
  }

  Widget _buildProjectDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project name with icon
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF22c55e), Color(0xFF16a34a)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.restaurant_menu_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.nutriPalName,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  AppStrings.nutriPalTagline,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Description
        const Text(
          AppStrings.nutriPalDescription,
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondary,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 24),
        // Features grid
        _buildFeaturesGrid(),
        const SizedBox(height: 24),
        // Tech stack
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            TechBadge(label: 'Flutter'),
            TechBadge(label: 'Dart'),
            TechBadge(label: 'Bloc'),
            TechBadge(label: 'REST API'),
            TechBadge(label: 'SQLite'),
            TechBadge(label: 'Firebase'),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturesGrid() {
    final features = [
      (AppStrings.nutriPalFeature1, Icons.psychology_rounded),
      (AppStrings.nutriPalFeature2, Icons.animation_rounded),
      (AppStrings.nutriPalFeature3, Icons.api_rounded),
      (AppStrings.nutriPalFeature4, Icons.cloud_off_rounded),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: features.map((feature) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.secondaryBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.borderColor.withOpacity(0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                feature.$2,
                color: AppTheme.accentPrimary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                feature.$1,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQRSection() {
    return Column(
      children: [
        // QR Code container
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Placeholder QR code
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomPaint(
                  size: const Size(160, 160),
                  painter: QRCodePainter(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                AppStrings.scanQrLabel,
                style: TextStyle(
                  color: Color(0xFF1a1a2e),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Action buttons
        _buildActionButton(
          label: AppStrings.viewOnGithub,
          icon: Icons.code_rounded,
          onTap: () => _launchUrl(AppLinks.nutriPalGithub),
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          label: AppStrings.downloadApk,
          icon: Icons.download_rounded,
          isPrimary: true,
          onTap: () => _launchUrl(AppLinks.nutriPalApk),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: isPrimary ? AppTheme.primaryGradient : null,
            color: isPrimary ? null : AppTheme.secondaryBg,
            borderRadius: BorderRadius.circular(10),
            border: isPrimary
                ? null
                : Border.all(color: AppTheme.borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isPrimary ? Colors.white : AppTheme.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: isPrimary ? Colors.white : AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

// Custom QR Code painter (simplified pattern)
class QRCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1a1a2e)
      ..style = PaintingStyle.fill;

    final cellSize = size.width / 25;
    
    // Draw corner squares
    _drawCornerSquare(canvas, paint, 0, 0, cellSize);
    _drawCornerSquare(canvas, paint, size.width - 7 * cellSize, 0, cellSize);
    _drawCornerSquare(canvas, paint, 0, size.height - 7 * cellSize, cellSize);
    
    // Draw random pattern for data
    final random = [
      [0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1],
      [1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1],
      [0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0],
      [1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1],
      [0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1],
      [1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0],
      [0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1],
      [1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0],
      [0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1],
      [1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0],
      [0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1],
    ];
    
    for (int row = 0; row < random.length; row++) {
      for (int col = 0; col < random[row].length; col++) {
        if (random[row][col] == 1) {
          canvas.drawRect(
            Rect.fromLTWH(
              (8 + col) * cellSize,
              (8 + row) * cellSize,
              cellSize,
              cellSize,
            ),
            paint,
          );
        }
      }
    }
  }

  void _drawCornerSquare(Canvas canvas, Paint paint, double x, double y, double cellSize) {
    // Outer square
    canvas.drawRect(Rect.fromLTWH(x, y, 7 * cellSize, 7 * cellSize), paint);
    
    // White inner
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(x + cellSize, y + cellSize, 5 * cellSize, 5 * cellSize), whitePaint);
    
    // Inner square
    canvas.drawRect(Rect.fromLTWH(x + 2 * cellSize, y + 2 * cellSize, 3 * cellSize, 3 * cellSize), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
