import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/widgets/section_header.dart';
import 'package:url_launcher/url_launcher.dart';

class MobilePortfolioSection extends StatelessWidget {
  const MobilePortfolioSection({super.key});

  // Update these URLs with your actual links
  static const String apkDownloadUrl = 'https://github.com/giahuyto3107/portfolio/build/app/outputs/flutter-apk/app-debug.apk';
  static const String demoVideoUrl = 'https://youtube.com/watch?v=your-demo-video';
  static const String portfolioAppUrl = 'https://yourusername.github.io/portfolio-app';

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.contentPadding,
        vertical: isMobile ? 60 : 80,
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
                title: 'Mobile Portfolio App',
                subtitle: 'Experience my portfolio on your mobile device',
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side - QR Code
          Expanded(
            flex: 2,
            child: _buildQRCodeSection(context),
          ),
          const SizedBox(width: 48),
          // Right side - Info & Actions
          Expanded(
            flex: 3,
            child: _buildInfoSection(context),
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
        children: [
          _buildQRCodeSection(context),
          const SizedBox(height: 32),
          _buildInfoSection(context),
        ],
      ),
    );
  }

  Widget _buildQRCodeSection(BuildContext context) {
    return Column(
      children: [
        // QR Code placeholder with gradient border
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // QR Code - Using a grid pattern as placeholder
                // In production, use qr_flutter package
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomPaint(
                    size: const Size(180, 180),
                    painter: _QRCodePlaceholderPainter(),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Scan to Download',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1a1a2e),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Point your camera at the QR code',
          style: TextStyle(
            fontSize: 13,
            color: AppTheme.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    final isMobile = context.isMobile;
    
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Phone mockup icon
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.phone_android_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Portfolio App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22c55e).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.android_rounded,
                            size: 14,
                            color: Color(0xFF22c55e),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Android',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF22c55e),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'v1.0.0',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Get my portfolio app on your Android device. Browse projects, view details, and stay updated with my latest work - all in a native mobile experience.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: const TextStyle(
            fontSize: 15,
            color: AppTheme.textSecondary,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 24),
        // Features list
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildFeatureChip(Icons.offline_bolt_rounded, 'Offline Access'),
            _buildFeatureChip(Icons.speed_rounded, 'Fast & Smooth'),
            _buildFeatureChip(Icons.dark_mode_rounded, 'Dark Theme'),
          ],
        ),
        const SizedBox(height: 32),
        // Action buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildDownloadButton(context),
            _buildDemoButton(context),
            _buildCopyLinkButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.accentPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.accentPrimary.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppTheme.accentPrimary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return _ActionButton(
      icon: Icons.download_rounded,
      label: 'Download APK',
      isPrimary: true,
      onTap: () async {
        final uri = Uri.parse(apkDownloadUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
    );
  }

  Widget _buildDemoButton(BuildContext context) {
    return _ActionButton(
      icon: Icons.play_circle_outline_rounded,
      label: 'Watch Demo',
      isPrimary: false,
      onTap: () async {
        final uri = Uri.parse(demoVideoUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
    );
  }

  Widget _buildCopyLinkButton(BuildContext context) {
    return _ActionButton(
      icon: Icons.link_rounded,
      label: 'Copy Link',
      isPrimary: false,
      onTap: () {
        Clipboard.setData(const ClipboardData(text: portfolioAppUrl));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                SizedBox(width: 12),
                Text('Link copied to clipboard!'),
              ],
            ),
            backgroundColor: AppTheme.accentPrimary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? AppTheme.primaryGradient : null,
            color: widget.isPrimary 
                ? null 
                : (_isHovered 
                    ? AppTheme.borderColor.withOpacity(0.5) 
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(10),
            border: widget.isPrimary 
                ? null 
                : Border.all(color: AppTheme.borderColor, width: 1.5),
            boxShadow: widget.isPrimary && _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.accentPrimary.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: widget.isPrimary ? Colors.white : AppTheme.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: widget.isPrimary ? Colors.white : AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// QR Code placeholder painter - replace with qr_flutter package for real QR codes
class _QRCodePlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1a1a2e)
      ..style = PaintingStyle.fill;

    final cellSize = size.width / 25;
    
    // Draw position detection patterns (corners)
    _drawPositionPattern(canvas, paint, 0, 0, cellSize);
    _drawPositionPattern(canvas, paint, size.width - 7 * cellSize, 0, cellSize);
    _drawPositionPattern(canvas, paint, 0, size.height - 7 * cellSize, cellSize);
    
    // Draw some random data modules for visual effect
    final random = [
      [10, 2], [12, 3], [14, 4], [11, 5], [13, 6],
      [2, 10], [3, 12], [4, 14], [5, 11], [6, 13],
      [10, 10], [11, 11], [12, 12], [13, 13], [14, 14],
      [15, 10], [16, 11], [17, 12], [18, 13], [10, 15],
      [8, 8], [9, 9], [10, 8], [8, 10], [16, 16],
      [17, 17], [18, 18], [19, 10], [10, 19], [15, 15],
    ];
    
    for (final pos in random) {
      canvas.drawRect(
        Rect.fromLTWH(pos[0] * cellSize, pos[1] * cellSize, cellSize, cellSize),
        paint,
      );
    }
  }

  void _drawPositionPattern(Canvas canvas, Paint paint, double x, double y, double cellSize) {
    // Outer square
    canvas.drawRect(Rect.fromLTWH(x, y, 7 * cellSize, 7 * cellSize), paint);
    
    // White inner square
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(x + cellSize, y + cellSize, 5 * cellSize, 5 * cellSize), whitePaint);
    
    // Black center square
    canvas.drawRect(Rect.fromLTWH(x + 2 * cellSize, y + 2 * cellSize, 3 * cellSize, 3 * cellSize), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
