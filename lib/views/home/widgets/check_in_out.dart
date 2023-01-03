import 'package:flutter/material.dart';

class CheckInOutWidget extends StatelessWidget {
  final String icon;
  final String label;
  final String? time;
  const CheckInOutWidget({
    super.key,
    required this.icon,
    required this.label,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: ImageIcon(
            AssetImage(icon),
          ),
        ),
        Text(
          time != null ? "--:--" : "--:--",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
