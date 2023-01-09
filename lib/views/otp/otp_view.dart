import 'dart:convert';

import 'package:eirad_app/views/bottom_nav/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';

import '../../utils/app_colors.dart';
import 'widgets/timer_widget.dart';

class OTPView extends StatefulWidget {
  final String mobile;
  final String otp;
  const OTPView({
    Key? key,
    required this.mobile,
    required this.otp,
  }) : super(key: key);

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final otpController = TextEditingController();
  final box = Hive.box('tokenBox');

  @override
  void initState() {
    super.initState();
    otpController.setText(widget.otp);
  }

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
              controller: otpController,
              autofocus: true,
              onSubmitted: (value) {
                otpVerify();
              },
            ),
          ],
        ),
      ),
    );
  }

  void otpVerify() async {
    final Map<String, String> body = {
      "phoneNumber": widget.mobile,
      "otp": widget.otp,
    };
    final response = await post(
      Uri.parse("http://165.232.186.165:3000/auth/verify-otp"),
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(response.body);
    debugPrint("$data");

    bool isSuccess = data['success'];

    if (isSuccess) {
      box.put('accessToken', data['data'][0]['accesstoken']);
      box.put('refreshToken', data['data'][0]['refreshtoken']);

      debugPrint("Token: ${box.get('accessToken')}");
      debugPrint("Refresh Token: ${box.get('refreshToken')}");

      navigateToHomeScreen();
    }
  }

  void navigateToHomeScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const BottomNavScreen(),
      ),
    );
  }
}
