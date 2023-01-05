import 'package:eirad_app/utils/app_colors.dart';
import 'package:eirad_app/views/bottom_nav/widgets/nav_item.dart';
import 'package:eirad_app/views/history/history_view.dart';
import 'package:eirad_app/views/home/home_screen.dart';
import 'package:eirad_app/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 0;
  List<Widget> screens = const [
    HomeScreen(),
    HistoryView(),
    ProfileView(),
  ];

  List<IconData> icons = [
    Icons.home_rounded,
    Icons.calendar_month,
    // FontAwesomeIcons.user,
    Icons.account_circle_outlined,
  ];
  List<String> labels = ["Home", "History", "Profile"];

  @override
  void initState() {
    super.initState();
    checkLocationAccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      backgroundColor: currentIndex == 0 ? AppColors.whiteColor : null,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        height: 75,
        decoration: BoxDecoration(
          color: AppColors.greenColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            screens.length,
            (index) => NavItem(
              icon: icons[index],
              color: index == currentIndex
                  ? AppColors.onBoardingBackground
                  : Colors.transparent,
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
              label: currentIndex == index ? labels[index] : null,
            ),
          ),
        ),
      ),
    );
  }

  void checkLocationAccess() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isDenied) {
      Permission.location.request();
    }
  }
}
