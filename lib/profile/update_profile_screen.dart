import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/profile/components/profile_pic.dart';
import 'package:managerment/theme/app_theme.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  static const Color _selectedColor = ThemeColor.grey500;
  static const Color _unSelectedColor = ThemeColor.grey500;

  Color _emailTFColor = _unSelectedColor;
  Color _fullnameTFcolor = _unSelectedColor;
  Color _passwordColor = _unSelectedColor;

  final FocusNode _emailTFFocusNode = FocusNode();
  final FocusNode _passwordTFFocusNode = FocusNode();
  final FocusNode _fullnameTFFocusNode = FocusNode();

  final TextEditingController _emailTFController = TextEditingController();
  final TextEditingController _passwordTFController = TextEditingController();
  final TextEditingController _fullnameTFController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailTFFocusNode.addListener(_onEmailTFFocusChange);
    _passwordTFFocusNode.addListener(_onPasswordTFFocusChange);
    _fullnameTFFocusNode.addListener(_onFullnameTFFocusChange);
  }

  @override
  void dispose() {
    _emailTFFocusNode.removeListener(_onEmailTFFocusChange);
    _emailTFFocusNode.dispose();
    _passwordTFFocusNode.removeListener(_onPasswordTFFocusChange);
    _passwordTFFocusNode.dispose();
    _fullnameTFFocusNode.removeListener(_onFullnameTFFocusChange);
    _fullnameTFFocusNode.dispose();
    super.dispose();
  }

  void _onEmailTFFocusChange() {
    setState(() {
      _emailTFColor = _emailTFFocusNode.hasFocus ? _selectedColor : _unSelectedColor;
    });
  }

  void _onPasswordTFFocusChange() {
    setState(() {
      _passwordColor = _passwordTFFocusNode.hasFocus ? _selectedColor : _unSelectedColor;
    });
  }

  void _onFullnameTFFocusChange() {
    setState(() {
      _fullnameTFcolor = _fullnameTFFocusNode.hasFocus ? _selectedColor : _unSelectedColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfilePic(),
        const SizedBox(height: 20),
        Form(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Get.isDarkMode?ThemeColor.primaryLight1:ThemeColor.dark1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _emailTFController,
                  focusNode: _emailTFFocusNode,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: GoogleFonts.poppins(color: _emailTFColor),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Get.isDarkMode?ThemeColor.primaryLight1:ThemeColor.dark1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _passwordTFController,
                  obscureText: true,
                  focusNode: _passwordTFFocusNode,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: GoogleFonts.poppins(color: _passwordColor),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Get.isDarkMode?ThemeColor.primaryLight1:ThemeColor.dark1,),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _fullnameTFController,
                  focusNode: _fullnameTFFocusNode,
                  decoration: InputDecoration(
                    labelText: "Fullname",
                    labelStyle: GoogleFonts.poppins(color: _fullnameTFcolor),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement save logic here
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.isDarkMode?ThemeColor.grey200:ThemeColor.primaryLight2,
                  ),
                  child:  Text('Save', style: GoogleFonts.poppins(
                    color: Get.isDarkMode?ThemeColor.primaryLight1:ThemeColor.background,
                  ),),
                ),
              ),
              const SizedBox(height: 40),
              Row(
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
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
