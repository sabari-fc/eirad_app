import 'package:eirad_app/utils/app_colors.dart';
import 'package:eirad_app/views/otp/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome!",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Log in to your eirad account",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.hintTextColor,
                          ),
                    ),
                    const SizedBox(height: 40),
                    IntlPhoneField(
                      disableLengthCheck: true,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'SA',
                      onCountryChanged: (value) {
                        debugPrint(value.code);
                      },
                      onChanged: (phone) {
                        debugPrint(phone.completeNumber);
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "You will receive an SMS verification that may apply message and data rates.",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.hintTextColor,
                          ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/login.png'),
                ],
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: MaterialButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => OTPView(),
                    ),
                  ),
                  minWidth: double.maxFinite,
                  height: 48,
                  color: AppColors.greenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteColor,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
