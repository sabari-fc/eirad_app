import 'dart:async';
import 'dart:math';

import 'package:eirad_app/services/notification_service.dart';
import 'package:eirad_app/utils/app_colors.dart';
import 'package:eirad_app/views/home/widgets/check_in_out.dart';
import 'package:eirad_app/views/home/widgets/time_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late LocalNotificationService notificationService;
  final box = Hive.box('attendance');
  late bool checkedIn;
  DateTime? checkIn, checkOut;

  @override
  void initState() {
    super.initState();
    notificationService = LocalNotificationService();
    checkedIn = box.get('checkedIn') ?? false;
    checkIn = box.get('check_in');
    checkOut = box.get('check_out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey Anju!",
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
            ),
            Text(
              DateTime.now().hour >= 6 && DateTime.now().hour < 12
                  ? "Good Morning!  Mark your attendance"
                  : DateTime.now().hour >= 12 && DateTime.now().hour < 16
                      ? "Good Afternoon!  Mark your attendance"
                      : DateTime.now().hour >= 16 && DateTime.now().hour < 20
                          ? "Good Evening!  Mark your attendance"
                          : "Good Night! Mark your attendance",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.greyColor,
                    fontStyle: FontStyle.normal,
                  ),
            ),
          ],
        ),
        actions: const [
          SizedBox(
            width: 50,
            height: 50,
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://media.istockphoto.com/id/1368423987/photo/young-woman-showing-her-strength.jpg?s=612x612&w=0&k=20&c=DYPz2Qa4_iL-ruKvVSJeTgoUg_KE7cv_NLKuwmYY-XU=",
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 48),
              const CurrentTimeWidget(),
              Text(
                DateFormat.yMMMMEEEEd().format(DateTime.now()),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.greyColor,
                      fontStyle: FontStyle.normal,
                      fontFamily: "SF Pro",
                    ),
              ),
              const SizedBox(height: 48),
              InkWell(
                onTap: () {
                  box.put('checkedIn', checkedIn ? false : true);
                  box.put(checkedIn ? "check_out" : 'check_in', DateTime.now());
                  setState(() {
                    checkedIn = !checkedIn;
                    checkIn = box.get('check_in');
                    checkOut = box.get('check_out');
                  });
                  notificationService.addNotification(
                    !checkedIn ? "Check Out" : "Check In",
                    "Today at ${DateFormat.jm().format(DateTime.now())}",
                    DateTime.now().millisecondsSinceEpoch + 1000,
                    channel: 'testing',
                  );
                },
                customBorder: const CircleBorder(),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(checkedIn
                      ? "assets/images/check_out_button.png"
                      : 'assets/images/check_button.png'),
                ),
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CheckInOutWidget(
                      icon: 'assets/images/check_in.png',
                      label: "Check In",
                      time: checkIn != null
                          ? DateFormat.jm().format(checkIn!)
                          : null,
                    ),
                    CheckInOutWidget(
                      icon: 'assets/images/check_out.png',
                      label: "Check Out",
                      time: checkOut != null
                          ? DateFormat.jm().format(checkOut!)
                          : null,
                    ),
                    CheckInOutWidget(
                      icon: 'assets/images/total_hrs.png',
                      label: "Total Hrs",
                      time: checkIn != null
                          ? "${checkOut?.difference(checkIn!).inHours.toString().padLeft(2, "0")}:${checkOut?.difference(checkIn!).inMinutes.toString().padLeft(2, "0")}"
                          : null,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
