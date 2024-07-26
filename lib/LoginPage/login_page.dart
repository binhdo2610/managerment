
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/LoginPage/forgot_password.dart';
import 'package:managerment/api_services/auth_api.dart';
import 'package:managerment/api_services/base_api.dart';
import 'package:managerment/api_services/decode_jwt.dart';
import 'package:managerment/home_page.dart';
import 'package:managerment/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../api_services/helper_function.dart';
import 'register_page.dart';

import '../api_services/auth_service.dart';
import '../api_services/database_service.dart';
import '../../widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  
  

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  late AuthApi _authApi = AuthApi();
  late decodeJwt _decode = decodeJwt();

  
  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Theme.of(context).primaryColor, // Màu tím
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/computer.jpg",
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Sign in to your account',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Enter your email and password to login',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 400,
                    color: Colors.white, // Màu trắng
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Please enter a valid email";
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            validator: (val) {
                              if (val!.length < 6) {
                                return "Password must be at least 6 characters";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColor.secondaryLight1, // Màu nền
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              "Log In",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              login();
                            },
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassPage()));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.poppins(
                                color: ThemeColor.secondaryLight1,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Divider(thickness: 1),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Or",
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Divider(thickness: 1),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: "Don't have an account? ",
                                style: GoogleFonts.poppins(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Register here",
                                    style: GoogleFonts.poppins(
                                      color: ThemeColor.secondaryLight1,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () { 
                                        nextScreen(context, const RegisterPage());//  logic đăng ký 
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (formKey.currentState!.validate()) {
      
      setState(() {
        _isLoading = true;
      });
      var token = await _authApi.login(email: email, password: password);
      
      await BaseAPI.saveToken(token);
      print(BaseAPI.token);
    //  await prefs.setString('token',token);
    
     
      // ignore: unnecessary_null_comparison
      if(token != null){

         showSnackbar(context, const  Color(0xFFFF5600), "Đăng nhập thành công");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(token: token)));
      }
      else { 
        setState(() {
          
        _isLoading = false;
          
        });
      }

      // firebase 
      await authService
          .loginWithUserNameandPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);
          // saving the values to our shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          
        } else {
          print("ko truy cap dc user tren firebase ");
        }
      });
    }
  }
}
