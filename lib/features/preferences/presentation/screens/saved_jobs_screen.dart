import 'package:flutter/material.dart';
import '../../../../core/services/saved_jobs_manager.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../dashboard/presentation/widgets/job_card.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: SavedJobsManager(),
          builder: (context, _) {
            final savedJobs = SavedJobsManager().savedJobs;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Subtitle
                  const Text(
                    'الوظائف المحفوظة',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    savedJobs.isEmpty
                        ? 'لا توجد وظائف محفوظة حالياً'
                        : '${savedJobs.length} ${savedJobs.length == 2 ? 'وظيفتان محفوذتان' : 'وظائف محفوظة'} للرجوع إليهم',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Saved Jobs List or Empty State
                  if (savedJobs.isEmpty) ...[
                    const SizedBox(height: 40),
                    const Center(
                      child: Text(
                        'لم تقم بحفظ أي وظيفة بعد',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ] else ...[
                    ...savedJobs.map(
                      (job) => Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: JobCard(
                          title: job.title,
                          location: job.location,
                          matchPercentage: job.matchPercentage,
                          tags: job.tags,
                          companyInitial: job.companyInitial,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),

                  // Info Banner Box at bottom
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.bookmark_rounded,
                          color: AppColors.primary,
                          size: 24,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'احتفظ بالوظائف المهمة في مكان واحد',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
