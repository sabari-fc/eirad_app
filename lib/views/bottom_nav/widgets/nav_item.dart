import 'package:eirad_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String? label;
  final Function() onTap;
  const NavItem({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.whiteColor,
            ),
            const SizedBox(width: 8),
            label != null
                ? Text(
                    label!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
