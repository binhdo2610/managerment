import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:managerment/Logic/Cubits/Language_cubits.dart';
import 'package:managerment/home_page.dart';
import 'package:managerment/shared/constants.dart';
import 'package:managerment/theme/app_theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:managerment/theme/theme_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'utils/sharePreferenceUtils.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SharedPrefs.init();
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubits(context),
      child: BlocBuilder<LanguageCubits, Locale?>(
        builder: (context, locale) {
          return GetMaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en'), // English
              Locale('vi'), // Spanish
            ],
            locale: locale,
            debugShowCheckedModeBanner: false,
            theme: ThemeColor.light,
            darkTheme: ThemeColor.dark,
            themeMode: ThemeService().theme,
            home: HomePage(
              fullname: '',
            ),
          );
        },
      ),
    );
  }
}
