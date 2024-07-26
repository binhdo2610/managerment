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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            AppLocalizations.of(context)!.profile,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
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
    return Column(
      children: [
        const ProfilePic(),
        const SizedBox(height: 10),
        Text(
          AppLocalizations.of(context)!.userName,
          style: GoogleFonts.poppins(color: ThemeColor.grey600, fontSize: 15),
        ),
        const SizedBox(height: 10),
        Text(
          'Email@gmail.com',
          style: GoogleFonts.poppins(color: ThemeColor.grey400, fontSize: 13),
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
              AppLocalizations.of(context)!.editProfile,
              style: GoogleFonts.poppins(color: ThemeColor.dark1),
            ),
          ),
        ),
        Divider(),
        const SizedBox(height: 10),
        ProfileMenu(
          text: AppLocalizations.of(context)!.notification,
          icon:  Icon(Icons.notifications, color: ThemeColor.grey700),
          press: () {},
        ),
        const SizedBox(height: 10),
        ProfileMenu(
          text: AppLocalizations.of(context)!.settings,
          icon:  Icon(Icons.settings, color: ThemeColor.grey700),
          press: () {},
        ),
        const SizedBox(height: 10),
        ProfileMenu(
          text: AppLocalizations.of(context)!.logout,
          icon:  Icon(Icons.logout, color: ThemeColor.grey700),
          press: () {},
        ),
      ],
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
