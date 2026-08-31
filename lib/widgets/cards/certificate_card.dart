import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../core/theme/app_colors.dart';

class CertificateCard extends StatefulWidget {
  final String title;
  final String platform;
  final String date;
  final Widget icon;
  final String? url;

  const CertificateCard({
    super.key,
    required this.title,
    required this.platform,
    required this.date,
    required this.icon,
    this.url,
  });

  @override
  State<CertificateCard> createState() => _CertificateCardState();
}

class _CertificateCardState extends State<CertificateCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (widget.url != null) {
            if (widget.url!.endsWith('.pdf')) {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: AppColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    width: isMobile ? double.infinity : 800,
                    height: isMobile ? MediaQuery.of(context).size.height * 0.8 : 600,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: AppColors.textSecondary),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SfPdfViewer.asset(widget.url!),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              launchUrl(Uri.parse(widget.url!));
            }
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isMobile ? double.infinity : 300,
        constraints: const BoxConstraints(minHeight: 280),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
          border: Border.all(
            color: isHovered
                ? AppColors.primary.withValues(alpha: 0.5)
                : Colors.transparent,
            width: 1,
          ),
        ),
        transform: isHovered
            ? Matrix4.translationValues(0.0, -8.0, 0.0)
            : Matrix4.identity(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isMobile ? 8 : 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
                  ),
                  child: widget.icon,
                ),
                const Spacer(),
                const Icon(
                  Icons.verified,
                  color: AppColors.secondary,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Flexible(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.platform,
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.date,
              style: TextStyle(
                fontSize: isMobile ? 12 : 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
