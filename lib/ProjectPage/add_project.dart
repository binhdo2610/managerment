
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/ProjectPage/project_page.dart';
import 'package:managerment/api_services/project_service.dart';
import 'package:managerment/theme/app_theme.dart';

class AddProjectScreen extends StatefulWidget {
  final Map? toProject;
  const AddProjectScreen({super.key, this.toProject});

  @override
  State<AddProjectScreen> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProjectScreen> {
  TextEditingController titleController = TextEditingController();
  bool isEdit = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final toProject = widget.toProject;
    if (toProject != null) {
      isEdit = true;
      final title = toProject['title'];
      titleController.text = title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Project' : 'Add Project',
          style: GoogleFonts.poppins(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 3,
                        cursorColor: Get.isDarkMode ? ThemeColor.background : ThemeColor.dark1,
                        style: GoogleFonts.poppins(
                          color: Get.isDarkMode ? ThemeColor.background : ThemeColor.dark1,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          labelText: "Title",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Get.isDarkMode ? ThemeColor.background : ThemeColor.dark1,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Get.isDarkMode ? ThemeColor.background : ThemeColor.dark1,
                            ),
                          ),
                          labelStyle: GoogleFonts.poppins(
                            color: Get.isDarkMode ? ThemeColor.background : ThemeColor.dark1,
                            fontSize: 30,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                             var result = isEdit ? await UpdateData() : await SubmitProject();
                            if (result) {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProjectPage(username: '',)));
                          }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textStyle: GoogleFonts.poppins(fontSize: 18),
                        ),
                        child: Text(isEdit ? 'Update' : 'Create'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> UpdateData() async {
    final toProject = widget.toProject;
    if (toProject == null) {
      return false;
    }
    final id = toProject['id'];
    return await ProjectService.updateProject(id, titleController.text, context);
  }

  Future<bool> SubmitProject() async {
    if (titleController.text.isNotEmpty) {
      var token = await ProjectService.SubmitProject(titleController.text, context);
      // ignore: unnecessary_null_comparison
      return token != null;
    }
    return true;
  }
}