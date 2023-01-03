import 'package:eirad_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TimeLabelWidget extends StatelessWidget {
  final String? time;
  final String label;
  const TimeLabelWidget({
    super.key,
    this.time,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          time ?? "--:--",
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 12,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6D7783),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
