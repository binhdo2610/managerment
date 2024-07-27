import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:managerment/ProjectPage/project_detail.dart';
import 'package:managerment/api_services/task_service.dart';
import 'package:managerment/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewTask extends StatefulWidget {
  final String projectId;
  final Map? todoList;
  const AddNewTask({Key? key, required this.projectId, this.todoList})
      : super(key: key);

  @override
  State<AddNewTask> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddNewTask> {
  final _formKey = GlobalKey<FormState>();
  bool isEdit = false;
  late TextEditingController titleController;
  late TextEditingController desController;
  late TextEditingController dateController;
  late TextEditingController startTime;
  late TextEditingController endTime;
  DateTime SelectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final todoList = widget.todoList;
    titleController = TextEditingController();
    desController = TextEditingController();
    dateController = TextEditingController(
        text: '${DateFormat("yyyy-MM-dd").format(this.SelectedDate)}');
    startTime = TextEditingController(
        text: '${DateFormat.jm().format(DateTime.now())}');
    endTime = TextEditingController(
        text:
            '${DateFormat.jm().format(DateTime.now().add(Duration(hours: 1)))}');
    if (todoList != null) {
      isEdit = true;
      final title = todoList['title'];
      final description = todoList['description'];
      final expiredAt = todoList['expiredAt'];
      DateTime expiredDate = DateTime.parse(expiredAt);
      String formattedDate = DateFormat('yyyy-MM-dd').format(expiredDate);
      titleController.text = title;
      desController.text = description;
      dateController.text = formattedDate;
    }
  }

  _selectedDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: this.SelectedDate,
        firstDate: DateTime(2005),
        lastDate: DateTime(2030));
    if (selected != null && selected != SelectedDate) {
      setState(() {
        SelectedDate = selected;
        dateController.text = '${DateFormat("yyyy-MM-dd").format(selected)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Get.isDarkMode ? ThemeColor.dark1 : ThemeColor.primaryLight1,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.arrow_left_square,
              size: 40, color: ThemeColor.background),
        ),
        title: Text(
          isEdit
              ? AppLocalizations.of(context)!.editTask
              : AppLocalizations.of(context)!.addNewTask,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
            decoration: TextDecoration.none,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Get.isDarkMode ? ThemeColor.dark1 : ThemeColor.primaryLight1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: TextFormField(
                        controller: titleController,
                        cursorColor: Colors.white,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.title,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        validator: (value) {
                          if (titleController.value == null ||
                              titleController.value.text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseEnterATitle;
                          }
                          return null; // added to return null if validation passes
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: TextFormField(
                        controller: dateController,
                        cursorColor: Colors.white,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.date,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _selectedDate(context);
                            },
                            child: Icon(
                              CupertinoIcons.calendar,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? ThemeColor.dark3
                              : ThemeColor.background,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: TextFormField(
                                controller: desController,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 3,
                                cursorColor: Get.isDarkMode
                                    ? ThemeColor.background
                                    : ThemeColor.dark1,
                                style: GoogleFonts.poppins(
                                  color: Get.isDarkMode
                                      ? ThemeColor.background
                                      : ThemeColor.dark1,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.description,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Get.isDarkMode
                                            ? ThemeColor.background
                                            : ThemeColor.dark3),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Get.isDarkMode
                                            ? ThemeColor.background
                                            : ThemeColor.dark3),
                                  ),
                                  fillColor: Get.isDarkMode
                                      ? ThemeColor.background
                                      : ThemeColor.dark3,
                                  labelStyle: GoogleFonts.poppins(
                                    color: Get.isDarkMode
                                        ? ThemeColor.background
                                        : ThemeColor.dark1,
                                    fontSize: 18,
                                  ),
                                ),
                                validator: (value) {
                                  if (desController.value.text.isEmpty) {
                                    return AppLocalizations.of(context)!.pleaseEnterADescription;
                                  }
                                  return null; // added to return null if validation passes
                                }),
                          ),
                          SizedBox(
                            height: 280,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                var result = isEdit
                                    ? await UpdateData()
                                    : await _submitTask();
                                if (result) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProjectDetail(
                                                projectId: widget.projectId,
                                              )));
                                }
                              }
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                color: ThemeColor.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  isEdit ? AppLocalizations.of(context)!.updateTask : AppLocalizations.of(context)!.createTask,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _submitTask() async {
    String title = titleController.text;
    String description = desController.text;
    String expiredAt = dateController.text;
    String projectId = widget.projectId;

    await TaskService.SubmitTask(
      projectId: projectId,
      title: title,
      description: description,
      expiredAt: expiredAt,
      context: context,
    );
    return true;
  }

  Future<bool> UpdateData() async {
    final todoList = widget.todoList;
    if (todoList == null) {
      return false;
    }
    final id = todoList['id'];
    String title = titleController.text;
    String description = desController.text;
    String expiredAt = dateController.text;
    return await TaskService.updateTodoList(
      id: id,
      title: title,
      description: description,
      expiredAt: expiredAt,
      context: context,
    );
  }
}
