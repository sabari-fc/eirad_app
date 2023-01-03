import 'dart:async';
import 'dart:math';

import 'package:eirad_app/utils/app_colors.dart';
import 'package:eirad_app/views/home/widgets/check_in_out.dart';
import 'package:eirad_app/views/home/widgets/time_widget.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  : DateTime.now().hour >= 12 && DateTime.now().hour < 20
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
      body: Padding(
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
                  ),
            ),
            const SizedBox(height: 48),
            InkWell(
              onTap: () {},
              customBorder: const CircleBorder(),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/check_button.png'),
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CheckInOutWidget(
                    icon: 'assets/images/check_in.png',
                    label: "Check In",
                  ),
                  CheckInOutWidget(
                    icon: 'assets/images/check_out.png',
                    label: "Check Out",
                  ),
                  CheckInOutWidget(
                    icon: 'assets/images/total_hrs.png',
                    label: "Total Hrs",
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
