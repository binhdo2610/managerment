import 'package:country_flags/country_flags.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/Logic/Cubits/Language_cubits.dart';
import 'package:managerment/ProjectPage/add_project.dart';
import 'package:managerment/ProjectPage/over_view_scroll.dart';
import 'package:managerment/theme/app_theme.dart';
import 'package:managerment/theme/theme_service.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatefulWidget {
  final String username;
  const ProjectPage({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  // List items = [];
  // bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //FetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: Drawer(
        // Add your drawer items here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: ThemeColor.info,
              ),
              child: Text(
                AppLocalizations.of(context)!.changeSomethings,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ThemeService().SwitchTheme();
              },
              child: ListTile(
                leading: Icon(Get.isDarkMode
                    ? Icons.wb_sunny_rounded
                    : Icons.nightlight_round),
                title: Text(AppLocalizations.of(context)!.darkLight),
              ),
            ),
            ExpansionTile(
              title: Text(AppLocalizations.of(context)!.languages),
              leading: Icon(Icons.language),
              children: [
                GestureDetector(
                  onTap: () =>
                      context.read<LanguageCubits>().change(Locale('en')),
                  child: ListTile(
                    leading: CountryFlag.fromCountryCode('US', shape: Circle()),
                    title: Text(AppLocalizations.of(context)!.english),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      context.read<LanguageCubits>().change(Locale('vi')),
                  child: ListTile(
                    leading: CountryFlag.fromCountryCode('VN', shape: Circle()),
                    title: Text(AppLocalizations.of(context)!.vietnamese),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: theme.scaffoldBackgroundColor,
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ThemeColor.primary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(
                              builder: (context) => GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Icon(
                                  CupertinoIcons.bars,
                                  size: 35,
                                  color: ThemeColor.background,
                                ),
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 123, 0, 245),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: const Icon(CupertinoIcons.bell,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.hello,
                              style: GoogleFonts.poppins(
                                color: ThemeColor.background,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              widget.username,
                              style: GoogleFonts.poppins(
                                color: ThemeColor.background,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.haveANiceDay,
                              style: GoogleFonts.poppins(
                                color: ThemeColor.background,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 38,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: ThemeColor.secondaryLight1,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddProjectScreen(),
                                      ),
                                    );
                                  },
                                  icon: Icon(CupertinoIcons.add,
                                      color: ThemeColor.background),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                AppLocalizations.of(context)!.createNewProject,
                                style: GoogleFonts.poppins(
                                  color: ThemeColor.background,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: ThemeColor.background,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ]),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)!.searchYourProjects,
                              hintStyle: GoogleFonts.montserrat(
                                color: ThemeColor.grey200,
                                fontSize: 18,
                              ),
                              icon: Icon(Icons.search,
                                  color: ThemeColor.primaryLight2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: OverViewScroll(),
                ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
