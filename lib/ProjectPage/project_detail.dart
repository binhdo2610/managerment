import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/AddNewTask/add_new_task.dart';
import 'package:managerment/ProjectPage/progress_cart.dart';
import 'package:managerment/TaskPage/task_page.dart';
import 'package:managerment/api_services/base_api.dart';
import 'package:managerment/model/task_model.dart';
import 'package:managerment/shared/constants.dart';
import 'package:managerment/theme/app_theme.dart'; // Import TaskPage

class ProjectDetail extends StatefulWidget {
  final String projectId;
  const ProjectDetail({Key? key, required this.projectId}) : super(key: key);

  @override
  State<ProjectDetail> createState() => _ProjectDetail();
}

class _ProjectDetail extends State<ProjectDetail> {
  List items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //FetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Details',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Container(
                  //   height: 100,
                  //   child: ProgressCart(projectName: 'a', completedPercent: 1),
                  //   ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddNewTask(projectId: widget.projectId)));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 123, 0, 245),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                CupertinoIcons.add_circled,
                                color: ThemeColor.background,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Add task',
                                style: GoogleFonts.poppins(
                                  color: ThemeColor.background,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // SingleChildScrollView(
            //   child: Container(
            //     height: double.maxFinite,
            //     width: double.maxFinite,
            //     child: ListView.builder(itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text('Sample'),
            //       );
            //     }),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Future<void> FetchTodo() async {
  //   // final projectId = widget.projectId;
  //   var url = '${BaseAPI.FLUTTER_API_URL}/api/Todolists';
  //   final response = await Dio()
  //       .get(url, options: Options(headers: BaseAPI.FLUTTER_ACCESS_TOKEN));
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.data.toString()) as List;
  //     final result = json;
  //     setState(() {
  //       items = result;
  //     });
  //   }
  // }
}
