import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:managerment/api_services/base_api.dart';
import 'dart:convert';
import 'package:managerment/profile/components/profile_pic.dart';
import 'package:managerment/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// Assuming this is where BaseAPI.FLUTTER_API_URL is defined

class UpdateProfileScreen extends StatefulWidget {
  final String userid;
  final Function(String, String) onSave;
  UpdateProfileScreen({Key? key, required this.userid, required this.onSave}) : super(key: key);

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
    _passwordTFFocusNode.addListener(_onPasswordTFFocusChange);
    _firstnameTFFocusNode.addListener(_onFirstnameTFFocusChange);
    _usernameTFFocusNode.addListener(_onUsernameTFFocusChange);
    _lastnameTFFocusNode.addListener(_onLastnameTFFocusChange);

    // Fetch user data
    fetchUserData(widget.userid);
  }

  Future<void> fetchUserData(String userid) async {
    var url = '${BaseAPI.FLUTTER_API_URL}/api/User/$userid';
    try {
      final response = await Dio().get(
        url,
        options: Options(
          headers: BaseAPI.FLUTTER_ACCESS_TOKEN,
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          _emailTFController.text = data['email'];
          _usernameTFController.text = data['username'];
          _firstnameTFController.text = data['firstname'];
          _lastnameTFController.text = data['lastname'];
          // Assuming password is not sent for security reasons
          // _passwordTFController.text = data['password'];
        });
      } else {
        print('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
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
      _firstnameTFcolor = _firstnameTFFocusNode.hasFocus ? _selectedColor : _unSelectedColor;
    });
  }

  void _onLastnameTFFocusChange() {
    setState(() {
      _lastnameTFcolor = _lastnameTFFocusNode.hasFocus ? _selectedColor : _unSelectedColor;
    });
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

  Future<void> updateUser(String id) async {
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
          headers: BaseAPI.FLUTTER_ACCESS_TOKEN,
        ),
        data: body,
      );

      if (response.statusCode == 200) {
        print('User updated successfully');
        Get.snackbar(
          'Thành công',
          'Thông tin đã được cập nhật',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Gọi hàm onSave để cập nhật dữ liệu ở ProfileScreen
        widget.onSave(_usernameTFController.text, _emailTFController.text);
      } else {
        print('Failed to update user: ${response.statusCode}');
        Get.snackbar(
          'Lỗi',
          'Cập nhật không thành công',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
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
                labelText: AppLocalizations.of(context)!.userName,
                labelColor: _usernameTFColor,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _passwordTFController,
                focusNode: _passwordTFFocusNode,
                labelText: AppLocalizations.of(context)!.password,
                labelColor: _passwordColor,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _firstnameTFController,
                focusNode: _firstnameTFFocusNode,
                labelText:  AppLocalizations.of(context)!.firstName,
                labelColor: _firstnameTFcolor,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _lastnameTFController,
                focusNode: _lastnameTFFocusNode,
                labelText: AppLocalizations.of(context)!.lastName,
                labelColor: _lastnameTFcolor,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _phoneTFController,
                focusNode: _phoneTFFocusNode,
                labelText: AppLocalizations.of(context)!.phone,
                labelColor: _phoneTFcolor,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () => updateUser(widget.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.isDarkMode ? ThemeColor.grey200 : ThemeColor.primaryLight2,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: GoogleFonts.poppins(
                      color: Get.isDarkMode ? ThemeColor.primaryLight1 : ThemeColor.background,
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
    String? errorText,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Get.isDarkMode ? ThemeColor.primaryLight1 : ThemeColor.dark1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: [
          TextField(
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
              errorText: errorText,
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                errorText,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20,),
        _buildTextField(
          controller: _emailTFController,
          focusNode: _emailTFFocusNode,
          labelText : 'Email',
          labelColor: _emailTFColor,
        ),SizedBox(height: 20,),
        _buildTextField(
          controller: _usernameTFController,
          focusNode: _usernameTFFocusNode,
          labelText: 'Username',
          labelColor: _usernameTFColor,
        ),SizedBox(height: 20,),
        _buildTextField(
          controller: _passwordTFController,
          focusNode: _passwordTFFocusNode,
          labelText: 'Password',
          labelColor: _passwordColor,
          obscureText: true,
        ),SizedBox(height: 20,),
        _buildTextField(
          controller: _firstnameTFController,
          focusNode: _firstnameTFFocusNode,
          labelText: 'First Name',
          labelColor: _firstnameTFcolor,
        ),SizedBox(height: 20,),
        _buildTextField(
          controller: _lastnameTFController,
          focusNode: _lastnameTFFocusNode,
          labelText: 'Last Name',
          labelColor: _lastnameTFcolor,
        ),SizedBox(height: 25,),
        ElevatedButton(
          onPressed: () {
            updateUser(widget.userid);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

