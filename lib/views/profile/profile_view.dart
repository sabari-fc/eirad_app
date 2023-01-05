import 'package:eirad_app/utils/app_colors.dart';
import 'package:eirad_app/views/profile/widgets/profile_menutile.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/profile_back.png',
                  fit: BoxFit.contain,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                          blurRadius: 30,
                          offset: Offset(4, 4),
                        )
                      ],
                    ),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/id/1368423987/photo/young-woman-showing-her-strength.jpg?s=612x612&w=0&k=20&c=DYPz2Qa4_iL-ruKvVSJeTgoUg_KE7cv_NLKuwmYY-XU=",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "Anju Sasidharan",
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "+966 56 152 8562",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.greyColor,
                ),
          ),
          const SizedBox(height: 24),
          ProfileMenuTile(
            icon: Icons.edit,
            label: "Edit Profile",
            onTap: () {},
          ),
          ProfileMenuTile(
            icon: Icons.logout,
            label: "Log Out",
            onTap: () {},
          ),
          SizedBox(height: size.height * 0.09),
          const Text(
            "Copyright © 2022 Eirad. All rights reserved",
            style: TextStyle(
              color: Color(0xFF6D7783),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
