import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:eirad_app/services/notification_service.dart';
import 'package:eirad_app/utils/app_colors.dart';
import 'package:eirad_app/views/home/widgets/check_in_out.dart';
import 'package:eirad_app/views/home/widgets/time_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late LocalNotificationService notificationService;
  final attendanceBox = Hive.box('attendance');
  final tokenBox = Hive.box('tokenBox');
  late bool checkedIn;
  late String token;
  DateTime? checkIn, checkOut;

  @override
  void initState() {
    super.initState();
    // Stores the saved token.
    token = tokenBox.get('accessToken');
    notificationService = LocalNotificationService();

    // Stores bool value of whether checked in or not.
    checkedIn = attendanceBox.get('checkedIn') ?? false;

    // Stores the check_in time.
    checkIn = attendanceBox.get('check_in');

    // Stores the check_out time.
    checkOut = attendanceBox.get('check_out');
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
                  // Updates the status of checked in or not in local storage.
                  attendanceBox.put('checkedIn', checkedIn ? false : true);

                  markAttendance();
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
                          ? DateFormat.jm().format(checkIn!.toLocal())
                          : null,
                    ),
                    CheckInOutWidget(
                      icon: 'assets/images/check_out.png',
                      label: "Check Out",
                      time: checkOut != null
                          ? DateFormat.jm().format(checkOut!.toLocal())
                          : null,
                    ),
                    CheckInOutWidget(
                      icon: 'assets/images/total_hrs.png',
                      label: "Total Hrs",
                      time: checkIn != null && checkOut != null
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
  bool get wantKeepAlive => true;

  void markAttendance() async {
    final snackBar = ScaffoldMessenger.of(context);
    final Map<String, String> body = {
      "type": checkedIn ? "PUNCH_OUT" : "PUNCH_IN",
    };
    final response = await post(
      Uri.parse("http://165.232.186.165:3000/attendances"),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var data = jsonDecode(response.body);
    debugPrint("$data");

    bool isSuccess = data['success'];

    if (isSuccess) {
      setState(() {
        checkedIn = !checkedIn;
        checkIn = DateTime.parse(data['data'][0]['punchIn']);
        checkOut = data['data'][0]['punchOut'] != null
            ? DateTime.parse(data['data'][0]['punchOut'])
            : null;
      });
      // Saves the time of check_in & check_out.
      attendanceBox.put(
        "check_out",
        checkOut,
      );
      attendanceBox.put(
        'check_in',
        checkIn,
      );
      showNotification();
    } else {
      // Shows the error message.
      snackBar.showSnackBar(SnackBar(content: Text(data['message'])));
    }
  }

  void showNotification() {
    notificationService.addNotification(
      !checkedIn ? "Check Out" : "Check In",
      "Today at ${DateFormat.jm().format(DateTime.now())}",
      DateTime.now().millisecondsSinceEpoch + 1000,
      channel: 'testing',
    );
  }
}
