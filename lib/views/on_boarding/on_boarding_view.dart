import 'package:eirad_app/utils/app_colors.dart';
import 'package:eirad_app/views/login/login_view.dart';
import 'package:eirad_app/views/on_boarding/data/on_boarding_data.dart';
import 'package:eirad_app/views/on_boarding/widgets/next_button.dart';
import 'package:eirad_app/views/on_boarding/widgets/on_boarding_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progress_border/progress_border.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView>
    with SingleTickerProviderStateMixin {
  late PageController pageController;
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );
  int currentIndex = 0;
  final box = Hive.box('initialStateBox');

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex == 1
          ? AppColors.greenColor
          : AppColors.onBoardingBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: GestureDetector(
                  onTap: () async {
                    final navigator = Navigator.of(context);

                    box.put('initialRun', false);
                    navigator.pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => const LoginView(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Skip",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OnBoardingTitleWidget(
                      subtitle: onboardingData[index].subtitle,
                      title: onboardingData[index].title,
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    Row(
                      mainAxisAlignment: index == 1
                          ? MainAxisAlignment.end
                          : index == 0
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          onboardingData[index].image,
                          alignment: Alignment.centerRight,
                          width: 300,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      onboardingData.length,
                      (dotIndex) => Container(
                        width: currentIndex == dotIndex ? 24 : 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          shape: currentIndex == dotIndex
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                          borderRadius: currentIndex == dotIndex
                              ? BorderRadius.circular(20)
                              : null,
                          color: currentIndex == dotIndex
                              ? AppColors.whiteColor
                              : AppColors.whiteColor.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                  NextButton(
                    onTap: () async {
                      if (currentIndex == onboardingData.length - 1) {
                        final navigator = Navigator.of(context);

                        box.put('initialRun', false);
                        navigator.pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => const LoginView(),
                          ),
                        );
                      }
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.bounceIn,
                      );
                    },
                    backgroundColor: currentIndex == 1
                        ? AppColors.onBoardingBackground
                        : AppColors.greenColor,
                    progressBorder: ProgressBorder.all(
                      color: AppColors.whiteColor,
                      width: 4,
                      progress: (currentIndex + 1) / onboardingData.length,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
