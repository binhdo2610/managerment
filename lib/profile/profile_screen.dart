import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/api_services/base_api.dart';
import 'package:managerment/profile/components/profile_menu.dart';
import 'package:managerment/profile/components/profile_pic.dart';
import 'package:managerment/profile/update_profile_screen.dart';
import 'package:managerment/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  final String id;
  const ProfileScreen({super.key, required this.id});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditingProfile = false;

  Future<bool> _onWillPop() async {
    if (_isEditingProfile) {
      setState(() {
        _isEditingProfile = false;
      });
      return false; // Prevent closing the bottom sheet
    } else {
      return true; // Allow closing the bottom sheet
    }
  }

Future fetchgetuserid() async {
  String userid = '99776b4e-1deb-45e0-a633-7499bdd6555b'; 
  var url = '${BaseAPI.FLUTTER_API_URL}/api/User/$userid';
 final response = await Dio().get(
      url,
      options: Options(
          headers: {'Authorization': 'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6Ijk5Nzc2YjRlLTFkZWItNDVlMC1hNjMzLTc0OTliZGQ2NTU1YiIsIkVtYWlsIjoiczM0MjMzNDMyZ0BnbWFpbC5jb20iLCJVc2VybmFtZSI6InN0cmluZyBzdHJpbmciLCJleHAiOjIwMzYzMzM2Mjd9.90noiX67ZDN47kYDoH3QrWOKol1Gypsgx-vKzsnp_5Q'},
           ),
    );
      if (response.statusCode == 200) {
        print('User updated successfully');
    } else {
     print('Failed to update user: ${response.statusCode}');
        print('Response data: ${response.data}');
      return []; 
      }
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColor.primary,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: _isEditingProfile ? _buildEditProfileContent() : _buildProfileContent(),
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    return Column(
      children: [
        const ProfilePic(),
        const SizedBox(height: 10),
        Text(
          'User Name',
          style: TextStyle(color: ThemeColor.grey600, fontSize: 15),
        ),
        const SizedBox(height: 10),
        Text(
          'Email@gmail.com',
          style: TextStyle(color: ThemeColor.grey400, fontSize: 13),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isEditingProfile = true;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColor.secondaryLight4,
              side: BorderSide.none,
              shape: StadiumBorder(),
            ),
            child: Text(
              'Edit Profile',
              style: GoogleFonts.poppins(color: ThemeColor.dark1),
            ),
          ),
        ),
        Divider(),
        const SizedBox(height: 10),
        ProfileMenu(
          text: "Notifications",
          icon: const Icon(Icons.notifications, color: ThemeColor.grey700),
          press: () {},
        ),
        const SizedBox(height: 10),
        ProfileMenu(
          text: "Settings",
          icon: const Icon(Icons.settings, color: ThemeColor.grey700),
          press: () {},
        ),
        const SizedBox(height: 10),
        ProfileMenu(
          text: "Log Out",
          icon: const Icon(Icons.logout, color: ThemeColor.grey700),
          press: () {},
        ),
      ],
    );
  }

  Widget _buildEditProfileContent() {
    return UpdateProfileScreen(id: widget.id);
  }
}
