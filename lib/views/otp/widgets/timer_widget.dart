import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? timer;
  Duration otpTime = const Duration(seconds: 120);

  @override
  void initState() {
    super.initState();
    startCountDown();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${strDigits(
        otpTime.inMinutes.remainder(60),
      )}: ${strDigits(
        otpTime.inSeconds.remainder(60),
      )}",
      style: Theme.of(context).textTheme.displaySmall,
    );
  }

  void startCountDown() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setCountdown(),
    );
  }

  setCountdown() {
    const secondsToBeReduced = 1;
    setState(() {
      final seconds = otpTime.inSeconds - secondsToBeReduced;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        otpTime = Duration(seconds: seconds);
      }
    });
  }

  String strDigits(int n) => n.toString().padLeft(2, '0');
}
