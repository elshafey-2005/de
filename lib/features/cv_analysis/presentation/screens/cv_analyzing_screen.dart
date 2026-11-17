import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/cv_state.dart';
import 'cv_analysis_result_screen.dart';

class CvAnalyzingScreen extends StatefulWidget {
  const CvAnalyzingScreen({super.key});

  @override
  State<CvAnalyzingScreen> createState() => _CvAnalyzingScreenState();
}

class _CvAnalyzingScreenState extends State<CvAnalyzingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _progressAnimation = Tween<double>(begin: 0.20, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    // Auto-navigate to result screen when animation finishes
    _navigationTimer = Timer(const Duration(milliseconds: 3000), () {
      if (mounted) {
        CvState().markCvUploaded();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CvAnalysisResultScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            final progress = _progressAnimation.value;
            final percentageInt = (progress * 100).clamp(0, 100).toInt();

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Column(
                      children: [
                        // Header Row with Back Button
                        Row(
                          children: [
                            const SizedBox(width: 44),
                            const Expanded(
                              child: Text(
                                'جارٍ تحليل سيرتك',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
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
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),

                        // Center Pulsing Sparkle Circle
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryLight,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                blurRadius: 24,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.auto_awesome,
                              color: AppColors.primary,
                              size: 56,
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Main Text Heading
                        const Text(
                          'بنكتشف مهاراتك ونقاط قوتك',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'قد تستغرق العملية لحظات بسيطة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Progress Percentage
                        Text(
                          '$percentageInt%',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Progress Bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 8,
                            width: double.infinity,
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: AppColors.borderLight,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Checklist Steps
                        _buildChecklistTile(
                          icon: Icons.check_circle_rounded,
                          iconColor: AppColors.success,
                          title: 'قراءة ملف PDF',
                          isCompleted: progress >= 0.35,
                        ),
                        const SizedBox(height: 14),
                        _buildChecklistTile(
                          icon: Icons.check_circle_rounded,
                          iconColor: AppColors.success,
                          title: 'استخراج المهارات',
                          isCompleted: progress >= 0.60,
                        ),
                        const SizedBox(height: 14),
                        _buildChecklistTile(
                          icon: Icons.auto_awesome,
                          iconColor: AppColors.primary,
                          title: 'مقارنة متطلبات الوظائف',
                          isCompleted: progress >= 0.85,
                        ),
                        const SizedBox(height: 14),
                        _buildChecklistTile(
                          icon: Icons.access_time_rounded,
                          iconColor: AppColors.textMuted,
                          title: 'حساب نسب التوافق',
                          isCompleted: progress >= 0.98,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildChecklistTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool isCompleted,
  }) {
    final effectiveIconColor = isCompleted ? AppColors.success : iconColor;
    final effectiveIcon = isCompleted ? Icons.check_circle_rounded : icon;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          effectiveIcon,
          color: effectiveIconColor,
          size: 20,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isCompleted ? FontWeight.bold : FontWeight.w500,
            color: isCompleted ? AppColors.textDark : AppColors.textMedium,
          ),
        ),
      ],
    );
  }
}
