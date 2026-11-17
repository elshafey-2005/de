import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class YearsCounterWidget extends StatelessWidget {
  final int count;
  final ValueChanged<int> onChanged;

  const YearsCounterWidget({
    super.key,
    required this.count,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Decrement (-)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: count > 0 ? () => onChanged(count - 1) : null,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.remove_rounded,
                  color: count > 0 ? AppColors.primary : AppColors.textMuted,
                  size: 24,
                ),
              ),
            ),
          ),

          // Value
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),

          // Increment (+)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onChanged(count + 1),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
