import 'package:eirad_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'label_widget.dart';

class EventTile extends StatelessWidget {
  final DateTime date;
  final DateTime checkIn;
  final DateTime checkOut;
  final String office;
  final String totalHrs;
  const EventTile({
    super.key,
    required this.checkIn,
    required this.checkOut,
    required this.date,
    required this.office,
    required this.totalHrs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
        top: 16,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: date == DateTime.now()
                  ? AppColors.onBoardingBackground
                  : AppColors.orangeRed,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  date.day.toString(),
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                ),
                Text(
                  DateFormat.E().format(date).substring(0, 2),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.whiteColor,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TimeLabelWidget(
                      time: DateFormat('hh:MM a').format(checkIn),
                      label: "Check In",
                    ),
                    const VerticalDivider(
                      thickness: 35,
                      color: Color(0xFfA7AAAD),
                    ),
                    TimeLabelWidget(
                      time: DateFormat('hh:MM a').format(checkOut),
                      label: "Check Out",
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    TimeLabelWidget(
                      time: totalHrs,
                      label: "Total Hrs",
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Text(
                  office,
                  style: const TextStyle(
                    color: Color(0xFF6D7783),
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
