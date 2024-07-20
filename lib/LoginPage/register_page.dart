import 'package:flutter/widgets.dart';
import 'package:managerment/LoginPage/login_page.dart';
import 'package:managerment/api_services/auth_api.dart';
import 'package:managerment/api_services/auth_service.dart';
import 'package:managerment/api_services/helper_function.dart';
import 'package:managerment/home_page.dart';

import '../../widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late AuthApi _authApi = AuthApi();
  String username = "";
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String firstname = "";
  String lastname = "";

  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // }
    // // gettingUserData() async {
    // //   await HelperFunctions.getUserEmailFromSF().then((value) {
    // //     setState(() {
    // //       email = value!;
    // //     });
    // //   });
    // //   await HelperFunctions.getUserNameFromSF().then((val) {
    // //     setState(() {
    // //       username = val!;
    // //     });
    // //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor))
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Groupie",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                            "Create your account now to chat and explore",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset("assets/logo.jpg"),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "Username",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              )),
                          onChanged: (val) {
                            setState(() {
                              username = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Username cannot be empty";
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "Last Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              )),
                          onChanged: (val) {
                            setState(() {
                              lastname = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name cannot be empty";
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "First Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              )),
                          onChanged: (val) {
                            setState(() {
                              firstname = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name cannot be empty";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              )),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },

                          // check tha validation
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please enter a valid email";
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              labelText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                              )),
                          validator: (val) {
                            return RegExp(
                                        r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$")
                                    .hasMatch(val!)
                                ? null
                                : "Please enter a valid password";
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:
                                    Color.fromARGB(255, 130, 233, 251),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              register();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Login now",
                                style: const TextStyle(
                                    color: Color(0xFFFF5600),
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, const LoginPage());
                                  }),
                          ],
                        )),
                      ],
                    )),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      var token = await _authApi.signupAPI(
          email, username, lastname, firstname, password);
      if (token != null) {
        await HelperFunctions.saveToken(token);

        print(token);
        showSnackbar(context, Colors.red, "Đăng kí thành công ");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(token: token,)));
      } else {
        setState(() {
          _isLoading = false;
        });
        throw Exception("Đăng kí thất bại ");
      }

      await authService
          .registerUserWithEmailandPassword(firstname, email, password)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(firstname);
        }
      });
    }
  }
}
