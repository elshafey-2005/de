import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../cv_analysis/presentation/controllers/cv_state.dart';
import '../../../cv_analysis/presentation/screens/cv_management_screen.dart';
import '../../../cv_analysis/presentation/screens/cv_upload_screen.dart';
import '../widgets/banner_card.dart';
import '../widgets/cv_status_card.dart';
import '../widgets/job_card.dart';
import '../widgets/stat_card.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onOpenPreferences;

  const HomeScreen({super.key, this.onOpenPreferences});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // User Avatar Placeholder
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primaryLight,
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'أهلاً بك 👋',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Khaled Abdelazez',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Notification Button
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
                    child: Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            color: AppColors.textDark,
                          ),
                          onPressed: () {},
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Banner Card
              const BannerCard(),
              const SizedBox(height: 20),

              // CV Status Card
              ListenableBuilder(
                listenable: CvState(),
                builder: (context, _) {
                  final cvState = CvState();
                  return CvStatusCard(
                    isUploaded: cvState.isUploaded,
                    fileName: cvState.fileName,
                    onTap: () {
                      if (cvState.isUploaded) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CvManagementScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CvUploadScreen(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),

              // Statistics Section (Row of 3 cards)
              const Row(
                children: [
                  Expanded(
                    child: StatCard(
                      value: '78',
                      label: 'الوظائف المتاحة',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      value: '92%',
                      label: 'نسبة التوافق',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      value: '24',
                      label: 'إجمالي طلباتك',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Jobs Selected for You Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'وظائف مختارة لك',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'عرض الكل',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Job Cards List
              const JobCard(
                title: 'Flutter Developer',
                location: 'مصر، القاهرة',
                matchPercentage: 'توافق 92%',
                tags: ['عن بعد', 'Flutter'],
                companyInitial: 'F',
              ),
              const SizedBox(height: 12),
              const JobCard(
                title: 'Senior Mobile Engineer',
                location: 'مصر، الإسكندرية',
                matchPercentage: 'توافق 88%',
                tags: ['هجين', 'Dart'],
                companyInitial: 'M',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
