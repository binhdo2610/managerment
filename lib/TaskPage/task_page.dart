import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:managerment/ProjectPage/progress_cart.dart';
import 'package:managerment/ProjectPage/project_page.dart';
import 'package:managerment/theme/app_theme.dart';


class TaskPage extends StatefulWidget {
  const TaskPage({
    Key? key,
    required this.Goback,
  }) : super(key: key);
  final void Function(int) Goback;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  
  DateTime _selectedDate = DateTime.now();
  void _onDateChange(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Material( // Add Material widget here
        child: Container(
          color: theme.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: Get.isDarkMode?ThemeColor.primaryLight1:ThemeColor.background,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, MaterialPageRoute(builder: (context)=> ProjectPage(username: '')));
                          },
                          child: Icon(
                            CupertinoIcons.arrow_left_square,
                            color: Get.isDarkMode?ThemeColor.background:ThemeColor.dark1,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${DateFormat('MMM, d').format(_selectedDate)}',
                          style: GoogleFonts.poppins(
                            color: Get.isDarkMode?ThemeColor.background:ThemeColor.dark1,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),  
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    DatePicker(
                      height: 88,
                      width: 70,
                      DateTime.now(),
                      initialSelectedDate: _selectedDate,
                      selectionColor: ThemeColor.primaryLight2,
                      onDateChange: _onDateChange,
                      dateTextStyle: GoogleFonts.poppins(fontSize: 23),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
