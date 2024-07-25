import 'package:dio/dio.dart';
import 'package:drag_and_drop/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/api_services/base_api.dart';
import 'package:managerment/api_services/user_service.dart';
import 'package:managerment/model/user_model.dart';
import 'package:managerment/profile/components/profile_menu.dart';
import 'package:managerment/profile/components/profile_pic.dart';
import 'package:managerment/profile/update_profile_screen.dart';
import 'package:managerment/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  final String userid;
  const ProfileScreen({super.key, required this.userid});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditingProfile = false;
  late Future<UserModel> futureUser;

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
  void initState() {
    super.initState();
    futureUser = UserService.getUser(widget.userid);
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
          child: _isEditingProfile
              ? _buildEditProfileContent()
              : _buildProfileContent(),
        ),
      ),
    );
  }
Widget _buildProfileContent() {
  return FutureBuilder<UserModel>(
    future: futureUser,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(
          child: Text('Error: ${snapshot.error}'),
        );
      } else if (snapshot.hasData) {
        UserModel user = snapshot.data!;
        return Column(
          children: [
            ProfilePic(), // Ensure ProfilePic has constrained dimensions
            SizedBox(height: 10),
            Text(
              user.email!,
              style: TextStyle(color: ThemeColor.grey600, fontSize: 15),
            ),
            SizedBox(height: 10),
            Text(
              user.username!,
              style: TextStyle(color: ThemeColor.grey400, fontSize: 13),
            ),
            SizedBox(height: 20),
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
                  shape: StadiumBorder(),
                ),
                child: Text(
                  'Edit Profile',
                  style: GoogleFonts.poppins(color: ThemeColor.dark1),
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            ProfileMenu(
              text: "Notifications",
              icon: Icon(Icons.notifications, color: ThemeColor.grey700),
              press: () {},
            ),
            SizedBox(height: 10),
            ProfileMenu(
              text: "Settings",
              icon: Icon(Icons.settings, color: ThemeColor.grey700),
              press: () {},
            ),
            SizedBox(height: 10),
            ProfileMenu(
              text: "Log Out",
              icon: Icon(Icons.logout, color: ThemeColor.grey700),
              press: () {},
            ),
          ],
        );
      } else {
        return Center(child: Text('No data available'));
      }
    },
  );
}


  Widget _buildEditProfileContent() {
    return UpdateProfileScreen(
      userid: widget.userid,
      onSave: (String updatedName, String updatedEmail) {
        setState(() {
          _isEditingProfile = false;
        });
      },
    );
  }
}
