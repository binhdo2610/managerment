import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:managerment/LoginPage/login_page.dart';
import 'package:managerment/ProjectPage/test.dart';
import 'package:managerment/api_services/helper_function.dart';
import 'package:managerment/home_page.dart';
import 'package:managerment/shared/constants.dart';
import 'package:managerment/theme/app_theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:managerment/theme/theme_service.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   bool _isSignedIn = false;
  @override
  void initState() {
   
    super.initState();
    // getUserLoggedInStatus();
  }

  // getUserLoggedInStatus() async {
  //   await HelperFunctions.getUserLoggedInStatus().then((value) {
  //     if (value != null) {
  //       setState(() {
  //         _isSignedIn = value;
  //       });
  //     }
  //   });
  // }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeColor.light,
      darkTheme: ThemeColor.dark,
      themeMode: ThemeService().theme,
      home: HomePage(fullname: '',),
    );
  }
}


