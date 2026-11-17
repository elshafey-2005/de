import 'package:flutter/material.dart';
import '../../../../core/services/saved_jobs_manager.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../preferences/presentation/screens/job_details_screen.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String location;
  final String matchPercentage;
  final List<String> tags;
  final String companyInitial;

  const JobCard({
    super.key,
    this.title = 'Flutter Developer',
    this.location = 'مصر، القاهرة',
    this.matchPercentage = 'توافق 92%',
    this.tags = const ['عن بعد', 'Flutter'],
    this.companyInitial = 'F',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailsScreen(
              title: title,
              location: location,
              matchPercentage: matchPercentage,
              companyInitial: companyInitial,
              tags: tags,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Icon / Initial
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        companyInitial,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Title and Location
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: AppColors.textMuted,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              location,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Bookmark Icon Button with Dynamic Saving
                  ListenableBuilder(
                    listenable: SavedJobsManager(),
                    builder: (context, _) {
                      final isSaved = SavedJobsManager().isSaved(title);
                      return IconButton(
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
                        icon: Icon(
                          isSaved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: AppColors.primary,
                        ),
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Tags Row
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...tags.map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.borderLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMedium,
                        ),
                      ),
                    ),
                  ),
                  // Match Percentage Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      matchPercentage,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
