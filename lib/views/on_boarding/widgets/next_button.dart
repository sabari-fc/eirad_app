import 'package:flutter/material.dart';
import 'package:progress_border/progress_border.dart';

import '../../../utils/app_colors.dart';

class NextButton extends StatelessWidget {
  final Function() onTap;
  final Color backgroundColor;
  final ProgressBorder progressBorder;

  const NextButton({
    Key? key,
    required this.onTap,
    required this.backgroundColor,
    required this.progressBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: progressBorder,
        shape: BoxShape.circle,
      ),
      child: MaterialButton(
        minWidth: 60,
        onPressed: onTap,
        shape: const CircleBorder(),
        color: backgroundColor,
        child: Icon(
          Icons.chevron_right,
          color: backgroundColor == AppColors.greenColor
              ? AppColors.whiteColor
              : Colors.black,
        ),
      ),
    );
  }
}
