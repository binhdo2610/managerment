import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/api_services/add_project_service.dart';
import 'package:managerment/theme/app_theme.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProjectScreen> {
  late AddProject addProject = AddProject();
  TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Project'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 3,
                  cursorColor:
                      Get.isDarkMode ? ThemeColor.background : ThemeColor.dark1,
                  style: GoogleFonts.poppins(
                    color: Get.isDarkMode
                        ? ThemeColor.background
                        : ThemeColor.dark1,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    labelText: "Title",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Get.isDarkMode
                              ? ThemeColor.background
                              : ThemeColor.dark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Get.isDarkMode
                              ? ThemeColor.background
                              : ThemeColor.dark1),
                    ),
                    fillColor: Get.isDarkMode
                        ? ThemeColor.background
                        : ThemeColor.dark1,
                    labelStyle: GoogleFonts.poppins(
                      color: Get.isDarkMode
                          ? ThemeColor.background
                          : ThemeColor.dark1,
                      fontSize: 20,
                    ),
                  ),
                  validator: (value) {
                    if (titleController.value.text.isEmpty) {
                      return 'Please enter a title';
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        
                      }
                      SubmitProject;
                    },
                    child: Text('Create'))
              ]),
        ),
      ),
    );
  }

  void SubmitProject() async {
    if (titleController.text.isNotEmpty) {
      var token = await addProject.SubmitProject(titleController.text, context);
    }
  }
}
