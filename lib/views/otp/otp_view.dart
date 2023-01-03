import 'package:eirad_app/views/bottom_nav/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../utils/app_colors.dart';
import 'widgets/timer_widget.dart';

class OTPView extends StatelessWidget {
  const OTPView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: TimerWidget()),
            const SizedBox(height: 16),
            Text(
              "We sent the code verification to your mobile number.",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.hintTextColor,
                  ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              child: const Text(
                "Send Again",
              ),
            ),
            const SizedBox(height: 16),
            Pinput(
              autofocus: true,
              onCompleted: (value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const BottomNavScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
