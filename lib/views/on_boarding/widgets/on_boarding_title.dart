import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class OnBoardingTitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const OnBoardingTitleWidget({
    super.key,
    required this.subtitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.whiteColor,
                ),
          ),
        ],
      ),
    );
  }
}
