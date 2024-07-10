import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:managerment/LoginPage/login_page.dart';
import 'package:managerment/api_services/auth_service.dart';
import 'package:managerment/profile/components/profile_menu.dart';
import 'package:managerment/profile/components/profile_pic.dart';
import 'package:managerment/profile/update_profile_screen.dart';
import 'package:managerment/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late AuthService _authService = AuthService();
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

          press: () async{
             await _authService.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false);
          },
        ),
      ],
    );
  }

  Widget _buildEditProfileContent() {
    return const UpdateProfileScreen();
  }
}
