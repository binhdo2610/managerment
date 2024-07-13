import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:managerment/api_services/base_api.dart';
import 'package:managerment/profile/components/profile_pic.dart';
import 'package:managerment/theme/app_theme.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String id;

  UpdateProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  static const Color _selectedColor = ThemeColor.grey500;
  static const Color _unSelectedColor = ThemeColor.grey500;

  Color _emailTFColor = _unSelectedColor;
  Color _usernameTFColor = _unSelectedColor;
  Color _firstnameTFcolor = _unSelectedColor;
  Color _passwordColor = _unSelectedColor;
  Color _lastnameTFcolor = _unSelectedColor;

  final FocusNode _emailTFFocusNode = FocusNode();
  final FocusNode _usernameTFFocusNode = FocusNode();
  final FocusNode _passwordTFFocusNode = FocusNode();
  final FocusNode _firstnameTFFocusNode = FocusNode();
  final FocusNode _lastnameTFFocusNode = FocusNode();

  final TextEditingController _firstnameTFController = TextEditingController();
  final TextEditingController _usernameTFController = TextEditingController();
  final TextEditingController _emailTFController = TextEditingController();
  final TextEditingController _passwordTFController = TextEditingController();
  final TextEditingController _lastnameTFController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailTFFocusNode.addListener(_onEmailTFFocusChange);
    _usernameTFFocusNode.addListener(_onUsernameTFFocusChange);
    _passwordTFFocusNode.addListener(_onPasswordTFFocusChange);
    _firstnameTFFocusNode.addListener(_onFirstnameTFFocusChange);
    _lastnameTFFocusNode.addListener(_onLastnameTFFocusChange);
  }

  @override
  void dispose() {
    _emailTFFocusNode.removeListener(_onEmailTFFocusChange);
    _emailTFFocusNode.dispose();
    _usernameTFFocusNode.removeListener(_onUsernameTFFocusChange);
    _usernameTFFocusNode.dispose();
    _passwordTFFocusNode.removeListener(_onPasswordTFFocusChange);
    _passwordTFFocusNode.dispose();
    _firstnameTFFocusNode.removeListener(_onFirstnameTFFocusChange);
    _firstnameTFFocusNode.dispose();
    _lastnameTFFocusNode.removeListener(_onLastnameTFFocusChange);
    _lastnameTFFocusNode.dispose();

    super.dispose();
  }

  void _onEmailTFFocusChange() {
    setState(() {
      _emailTFColor = _emailTFFocusNode.hasFocus ? _selectedColor : _unSelectedColor;
    });
  }

  void _onUsernameTFFocusChange() {
    setState(() {
      _usernameTFColor = _usernameTFFocusNode.hasFocus ? _selectedColor : _unSelectedColor;
    });
  }

  void _onPasswordTFFocusChange() {
    setState(() {
      _passwordColor = _passwordTFFocusNode.hasFocus ? _selectedColor : _unSelectedColor;
    });
  }

  void _onFirstnameTFFocusChange() {
    setState(() {
      _firstnameTFcolor =
          _firstnameTFFocusNode.hasFocus ? _selectedColor : _unSelectedColor;
    });
  }

  void _onLastnameTFFocusChange() {
    setState(() {
      _lastnameTFcolor =
          _lastnameTFFocusNode.hasFocus ? _selectedColor : _unSelectedColor;
    });
  }

  Future<void> updateUser(String id) async {
    if (id.isEmpty) {
      print('ID is required to update user');
      return;
    }

    final url = '${BaseAPI.FLUTTER_API_URL}/api/User/$id';

    final body = json.encode({
      'email': _emailTFController.text,
      'username': _usernameTFController.text,
      'firstname': _firstnameTFController.text,
      'lastname': _lastnameTFController.text,
      'password': _passwordTFController.text,
    });

    try {
      final response = await Dio().put(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6Ijk5Nzc2YjRlLTFkZWItNDVlMC1hNjMzLTc0OTliZGQ2NTU1YiIsIkVtYWlsIjoiczM0MjMzNDMyZ0BnbWFpbC5jb20iLCJVc2VybmFtZSI6InN0cmluZyBzdHJpbmciLCJleHAiOjIwMzYzMzM2Mjd9.90noiX67ZDN47kYDoH3QrWOKol1Gypsgx-vKzsnp_5Q'},
           ),
        data: body,
      );

      if (response.statusCode == 200) {
        print('User updated successfully');
        setState(() {});
      } else {
        print('Failed to update user: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        const SizedBox(height: 25),
        Form(
          child: Column(
            children: [
              _buildTextField(
                controller: _emailTFController,
                focusNode: _emailTFFocusNode,
                labelText: 'Email',
                labelColor: _emailTFColor,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _usernameTFController,
                focusNode: _usernameTFFocusNode,
                labelText: 'Username',
                labelColor: _usernameTFColor,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _passwordTFController,
                focusNode: _passwordTFFocusNode,
                labelText: 'Password',
                labelColor: _passwordColor,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _firstnameTFController,
                focusNode: _firstnameTFFocusNode,
                labelText: 'Firstname',
                labelColor: _firstnameTFcolor,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _lastnameTFController,
                focusNode: _lastnameTFFocusNode,
                labelText: 'Lastname',
                labelColor: _lastnameTFcolor,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () => updateUser(widget.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.isDarkMode
                        ? ThemeColor.grey200
                        : ThemeColor.primaryLight2,
                  ),
                  child: Text(
                    'Save',
                    style: GoogleFonts.poppins(
                      color: Get.isDarkMode
                          ? ThemeColor.primaryLight1
                          : ThemeColor.background,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Joined in 12 October 2023',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                      elevation: 0,
                      foregroundColor: Colors.red,
                      shape: const StadiumBorder(),
                      side: BorderSide.none,
                    ),
                    child: Text('Delete', style: GoogleFonts.poppins()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String labelText,
    required Color labelColor,
    bool obscureText = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(
            color: Get.isDarkMode ? ThemeColor.primaryLight1 : ThemeColor.dark1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        onChanged: (value) {
          setState(() {}); // This will trigger a rebuild to show the updated value
        },
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.poppins(color: labelColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
