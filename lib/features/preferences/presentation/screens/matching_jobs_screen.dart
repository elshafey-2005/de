import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../dashboard/presentation/widgets/job_card.dart';

class MatchingJobsScreen extends StatefulWidget {
  const MatchingJobsScreen({super.key});

  @override
  State<MatchingJobsScreen> createState() => _MatchingJobsScreenState();
}

class _MatchingJobsScreenState extends State<MatchingJobsScreen> {
  String _selectedFilter = 'الكل';

  final List<Map<String, dynamic>> _allJobs = [
    {
      'title': 'Junior Flutter Developer',
      'location': 'قويسنا، القاهرة',
      'matchPercentage': 'توافق 92%',
      'tags': ['Flutter', 'عن بعد'],
      'companyInitial': 'F',
    },
    {
      'title': 'Flutter Developer - Remote',
      'location': 'عن بعد - مصر',
      'matchPercentage': 'توافق 87%',
      'tags': ['Flutter', 'عن بعد'],
      'companyInitial': 'T',
    },
    {
      'title': 'Mobile App Developer',
      'location': 'عبدالعزيز - القاهرة',
      'matchPercentage': 'توافق 76%',
      'tags': ['Flutter', 'عن بعد'],
      'companyInitial': 'V',
    },
    {
      'title': 'Frontend Web & Mobile Engineer',
      'location': 'القاهرة، مصر',
      'matchPercentage': 'توافق 81%',
      'tags': ['Frontend', 'Flutter', 'React'],
      'companyInitial': 'FE',
    },
  ];

  List<Map<String, dynamic>> get _filteredJobs {
    if (_selectedFilter == 'الكل') {
      return _allJobs;
    }
    return _allJobs.where((job) {
      final tags = job['tags'] as List<String>;
      final title = job['title'] as String;
      final location = job['location'] as String;
      return tags.contains(_selectedFilter) ||
          title.toLowerCase().contains(_selectedFilter.toLowerCase()) ||
          location.contains(_selectedFilter);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredJobs = _filteredJobs;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Subtitle
              const Text(
                'الوظائف المناسبة',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'تم العثور على ${filteredJobs.length} وظيفة مناسبة لسيرتك الذاتية',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 18),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ابحث عن وظيفة أو شركة',
                    hintStyle: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Filter Chips Row (Interactive)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('Frontend'),
                    const SizedBox(width: 8),
                    _buildFilterChip('عن بعد'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Flutter'),
                    const SizedBox(width: 8),
                    _buildFilterChip('الكل'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Sort Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Filter Button
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.tune_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    label: const Text(
                      'تصنيف',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  // Sort Text
                  const Text(
                    'مرتبة حسب أعلى توافق',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Job Cards or Empty State
              if (filteredJobs.isEmpty) ...[
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'لا توجد وظائف مطابقة لهذا الفلتر',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ] else ...[
                ...filteredJobs.map(
                  (job) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: JobCard(
                      title: job['title'] as String,
                      location: job['location'] as String,
                      matchPercentage: job['matchPercentage'] as String,
                      tags: List<String>.from(job['tags']),
                      companyInitial: job['companyInitial'] as String,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.textMedium,
          ),
        ),
      ),
    );
  }
}
