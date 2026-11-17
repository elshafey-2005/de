import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../cv_analysis/presentation/controllers/cv_state.dart';
import '../../../cv_analysis/presentation/screens/cv_management_screen.dart';
import '../../../cv_analysis/presentation/screens/cv_upload_screen.dart';
import '../../../dashboard/presentation/screens/main_layout.dart';
import '../widgets/preference_chip_group.dart';
import '../widgets/years_counter_widget.dart';

class CareerPreferencesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onSave;

  const CareerPreferencesScreen({super.key, this.onBack, this.onSave});

  @override
  State<CareerPreferencesScreen> createState() => _CareerPreferencesScreenState();
}

class _CareerPreferencesScreenState extends State<CareerPreferencesScreen> {
  String selectedSpecialization = 'Flutter';
  String selectedExperienceLevel = 'مبتدئ';
  int yearsOfExperience = 1;
  String selectedWorkType = 'عن بعد';
  late final TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    cityController = TextEditingController(text: 'القاهرة');
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (widget.onSave != null) {
      widget.onSave!();
    } else if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainLayout(initialIndex: 0),
        ),
      );
    }
  }

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
              // Header Row with Back Button
              Row(
                children: [
                  const SizedBox(width: 44), // Balances center title
                  Expanded(
                    child: Column(
                      children: const [
                        Text(
                          'التفضيلات المهنية',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'خلّنا نعرف الوظائف اللي تناسبك',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Back Button Container
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
                      onPressed: () {
                        if (widget.onBack != null) {
                          widget.onBack!();
                        } else if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainLayout(initialIndex: 0),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // CV Analysis Banner Card
              ListenableBuilder(
                listenable: CvState(),
                builder: (context, _) {
                  final cvState = CvState();
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cvState.isUploaded ? AppColors.cardBackground : AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: cvState.isUploaded ? AppColors.borderLight : AppColors.primary.withValues(alpha: 0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
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
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  cvState.isUploaded ? Icons.description_outlined : Icons.cloud_upload_outlined,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cvState.isUploaded ? 'تم تحليل سيرتك بنجاح' : 'تحليل السيرة الذاتية',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      cvState.isUploaded
                                          ? 'اضغط لإدارة ملف سيرتك الذاتية'
                                          : 'قم برفع سيرتك الذاتية لاكتشاف التوافق المهني',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (cvState.isUploaded)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  size: 22,
                                  color: AppColors.success,
                                )
                              else
                                const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Section 1: Specialization
              const Text(
                'التخصص المهني',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 14),
              PreferenceChipGroup(
                options: const [
                  'Flutter',
                  'Frontend',
                  'Backend',
                  'Full-stack',
                  'Data / AI',
                  'Mobile',
                ],
                selectedOption: selectedSpecialization,
                onSelected: (val) {
                  setState(() => selectedSpecialization = val);
                },
              ),
              const SizedBox(height: 24),

              // Section 2: Experience Level
              const Text(
                'مستوى الخبرة',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 14),
              PreferenceChipGroup(
                options: const ['خبير', 'متوسط', 'مبتدئ'],
                selectedOption: selectedExperienceLevel,
                onSelected: (val) {
                  setState(() => selectedExperienceLevel = val);
                },
              ),
              const SizedBox(height: 24),

              // Section 3: Years of Experience
              const Text(
                'سنوات الخبرة',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 14),
              YearsCounterWidget(
                count: yearsOfExperience,
                onChanged: (val) {
                  setState(() => yearsOfExperience = val);
                },
              ),
              const SizedBox(height: 24),

              // Section 4: Work Type
              const Text(
                'نوع العمل',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 14),
              PreferenceChipGroup(
                options: const ['هجين', 'من المكتب', 'عن بعد'],
                selectedOption: selectedWorkType,
                onSelected: (val) {
                  setState(() => selectedWorkType = val);
                },
              ),
              const SizedBox(height: 24),

              // Section 5: Preferred City
              const Text(
                'المدينة المفضلة',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 10),
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
                  controller: cityController,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'أدخل مدينتك المفضلة',
                    hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    suffixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 4,
                    shadowColor: AppColors.primary.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'حفظ التفضيلات',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
