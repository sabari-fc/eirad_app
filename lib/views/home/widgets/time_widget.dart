import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';

class CurrentTimeWidget extends StatefulWidget {
  const CurrentTimeWidget({super.key});

  @override
  State<CurrentTimeWidget> createState() => _CurrentTimeWidgetState();
}

class _CurrentTimeWidgetState extends State<CurrentTimeWidget> {
  late DateTime time;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      setState(() {
        time = now;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat.jm().format(time),
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
          ),
    );
  }
}
