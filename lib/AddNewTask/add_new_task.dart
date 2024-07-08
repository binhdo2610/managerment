import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:managerment/model/project_model.dart';
import 'package:managerment/model/task_model.dart';
import 'package:managerment/theme/app_theme.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddNewTask> {
  late Project idProject;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController desController;
  late TextEditingController dateController;
  late TextEditingController startTime;
  late TextEditingController endTime;
  DateTime SelectedDate = DateTime.now();
  String Category = 'Meetings';

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    desController = TextEditingController();
    dateController = TextEditingController(
        text: '${DateFormat('EEE, MMM d, yyyy').format(this.SelectedDate)}');
    startTime = TextEditingController(
        text: '${DateFormat.jm().format(DateTime.now())}');
    endTime = TextEditingController(
        text:
            '${DateFormat.jm().format(DateTime.now().add(Duration(hours: 1)))}');
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
        dateController.text =
            '${DateFormat('EEE, MMM d, yy').format(selected)}';
      });
    }
  }

  _selectedTime(BuildContext context, String timeType) async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        if (timeType == 'StartTime') {
          startTime.text = result.format(context);
        } else if (timeType == 'EndTime') {
          endTime.text = result.format(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Color.fromRGBO(130, 0, 255, 1),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 20, top: 10, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(CupertinoIcons.arrow_left_square,
                                size: 40, color: Colors.white),
                          ),
                          SizedBox(
                            width: 70,
                          ),
                          Text(
                            'Add New Task',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 25,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          labelText: 'Title',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          fillColor: Colors.white,
                          labelStyle: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        validator: (value){
                          if(titleController.value == null || titleController.value.text.isEmpty)
                          return 'This field is required';
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: TextFormField(
                        controller: dateController,
                        cursorColor: Colors.white,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date',
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
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: TextField(
                                    readOnly: true,
                                    controller: startTime,
                                    decoration: InputDecoration(
                                      labelText: "Start Time",
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _selectedTime(context, 'StartTime');
                                        },
                                        child: Icon(
                                          CupertinoIcons.alarm,
                                          size: 30,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black45),
                                      ),
                                      fillColor: Colors.black45,
                                      labelStyle: GoogleFonts.poppins(
                                        color: Colors.black87,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: TextField(
                                      readOnly: true,
                                      controller: endTime,
                                      decoration: InputDecoration(
                                        labelText: 'End Time',
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            _selectedTime(context, "EndTime");
                                          },
                                          child: Icon(
                                            CupertinoIcons.alarm,
                                            size: 30,
                                            color: ThemeColor.dark1,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black45),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black45),
                                        ),
                                        fillColor: Colors.black45,
                                        labelStyle: GoogleFonts.poppins(
                                          color: Colors.black87,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: TextFormField(
                              controller: desController,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 3,
                              cursorColor: Colors.black45,
                              style: GoogleFonts.poppins(
                                color: ThemeColor.dark1,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                labelText: "Description",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black26),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black26),
                                ),
                                fillColor: Colors.black45,
                                labelStyle: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontSize: 18,
                                ),
                              ),
                              validator: (value) {
                                if (desController.value.text.isEmpty) {
                                  return 'Please enter a description';
                                }
                              }
                            ),
                          ),
                          SizedBox(
                            height: 250,
                          ),
                          GestureDetector(
                            onTap: () {
                              if(_formKey.currentState?.validate()?? false){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Data'))
                                ); 
                                }
                                print("${titleController.value.text}, ${desController.value.text}");
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(130, 0, 255, 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Create task",
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
  // void SubmitData(){
  //   final title = titleController.text;
  //   final description = desController.text;
  //   final expiredAt = dateController.text;
  //   final idProject = idProject;

  //   final body ={
  //     "title": title,
  //     "description": description,
  //     "expiredAt": expiredAt,
  //     "idProject"
  //   }
  // }
}
