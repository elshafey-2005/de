import 'package:flutter/material.dart';
import '../../../../core/services/saved_jobs_manager.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../cv_analysis/presentation/widgets/cv_score_circle.dart';
import 'job_application_success_screen.dart';

class JobDetailsScreen extends StatelessWidget {
  final String title;
  final String location;
  final String matchPercentage;
  final String companyInitial;
  final List<String> tags;

  const JobDetailsScreen({
    super.key,
    this.title = 'Junior Flutter Developer',
    this.location = 'القاهرة، مصر',
    this.matchPercentage = 'توافق 92%',
    this.companyInitial = 'F',
    this.tags = const ['Flutter', 'عن بعد', 'دوام كامل'],
  });

  @override
  Widget build(BuildContext context) {
    double percentageVal = 0.92;
    if (matchPercentage.contains('92')) {
      percentageVal = 0.92;
    } else if (matchPercentage.contains('87')) {
      percentageVal = 0.87;
    } else if (matchPercentage.contains('76')) {
      percentageVal = 0.76;
    } else if (matchPercentage.contains('96')) {
      percentageVal = 0.96;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top App Bar Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Bookmark Button with Dynamic Saving
                        ListenableBuilder(
                          listenable: SavedJobsManager(),
                          builder: (context, _) {
                            final isSaved = SavedJobsManager().isSaved(title);
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.borderLight),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(
                                  isSaved
                                      ? Icons.bookmark_rounded
                                      : Icons.bookmark_border_rounded,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                                onPressed: () {
                                  SavedJobsManager().toggleSave(
                                    title: title,
                                    location: location,
                                    matchPercentage: matchPercentage,
                                    tags: tags,
                                    companyInitial: companyInitial,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        isSaved
                                            ? 'تم إزالة الوظيفة من المحفوظات'
                                            : 'تم حفظ الوظيفة بنجاح',
                                      ),
                                      backgroundColor: AppColors.primary,
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        // Title
                        const Text(
                          'تفاصيل الوظيفة',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),

                        // Back Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.borderLight),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                              color: AppColors.textDark,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Company Initial Badge
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          companyInitial,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Job Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'فوري • $location • دوام كامل',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Match Summary Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.borderLight),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CvScoreCircle(
                            percentage: percentageVal,
                            label: 'توافق',
                            size: 80,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'توافق ممتاز مع الوظيفة',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'متطابق مع مهاراتك الأساسية والأساسية',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Section 1: Required Core Skills
                    Align(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'المهارات الاساسية المطلوبة',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: const [
                          _SkillChip(label: 'Flutter ✓'),
                          _SkillChip(label: 'Dart ✓'),
                          _SkillChip(label: 'REST API ✓'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Section 2: Preferred Skills
                    Align(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'المهارات المفضلة',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: const [
                          _SkillChip(label: 'Unit Testing'),
                          _SkillChip(label: 'CI/CD'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Apply Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobApplicationSuccessScreen(
                          jobTitle: title,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 4,
                    shadowColor: AppColors.primary.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'التقديم على الوظيفة',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;

  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
