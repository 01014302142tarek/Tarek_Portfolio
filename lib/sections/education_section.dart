import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../core/theme/app_colors.dart';
import '../../core/data/portfolio_data.dart';
import '../../core/widgets/section_title.dart';
import '../../core/utils/icon_helper.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  List<Map<String, dynamic>> get educationList =>
      List<Map<String, dynamic>>.from(PortfolioData.data['education'] ?? []);

  @override
  Widget build(BuildContext context) {
    if (educationList.isEmpty) return const SizedBox.shrink();

    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(title: 'Education'),
          SizedBox(height: isMobile ? 32 : 60),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: educationList.length,
              itemBuilder: (context, index) {
                return _EducationItem(
                  education: educationList[index],
                  isLast: index == educationList.length - 1,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationItem extends StatelessWidget {
  final Map<String, dynamic> education;
  final bool isLast;
  final int index;

  const _EducationItem({
    required this.education,
    required this.isLast,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Stack(
      children: [
        // Line
        if (!isLast)
          Positioned(
            left: 11, // Half of dot width (24/2) - half of line width (2/2)
            top: 24,
            bottom: 0,
            child: Container(
              width: 2,
              color: AppColors.secondary.withValues(alpha: 0.3),
            ),
          ),
        // Dot
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.cardBackground,
              border: Border.all(color: AppColors.secondary, width: 4),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.5),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
        ),
        // Content
        Padding(
          padding: EdgeInsets.only(
            left: 48,
            bottom: isLast ? 0 : 40,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isMobile)
                  Text(
                    education['period'] ?? '',
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (isMobile) const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          if (education['icon'] != null) ...[
                            FaIcon(
                              IconHelper.getIcon(education['icon']),
                              size: 20,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: Text(
                              education['degree'] ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile)
                      Text(
                        education['period'] ?? '',
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  education['university'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (education['grade'] != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      'Grade: ${education['grade']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ).animate(delay: (200 * index).ms).fadeIn(duration: 500.ms).slideX(begin: 0.1, end: 0),
      ],
    );
  }
}
