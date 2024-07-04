import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/AddNewTask/add_new_task.dart';
import 'package:managerment/ProjectPage/progress_cart.dart';
import 'package:managerment/TaskPage/task_page.dart';
import 'package:managerment/model/task_model.dart';
import 'package:managerment/theme/app_theme.dart'; // Import TaskPage

class ProjectDetail extends StatefulWidget {
 
  const ProjectDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectDetail> createState() => _ProjectDetail();
}

class _ProjectDetail extends State<ProjectDetail> {
  late TabController tabController;
  final List<Task> _tasks = [];

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
                  Container(
                    height: 100,
                    child: ProgressCart(projectName: 'a', completedPercent: 1),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          child: Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                        ),
                      ),
                      SizedBox(width: 50,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddNewTask()));
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
            _buildTaskList()
          ],
        ),
      ),
      // floatingActionButton: ClipOval(
      //   child: Container(
      //     width: 85, // Increase the width
      //     height: 85, // Increase the height
      //     child: FloatingActionButton(
      //       onPressed: () {
      //         // Handle floating button press action
      //       },
      //       child: Container(
      //         decoration: BoxDecoration(
      //             shape: BoxShape.circle,
      //             border: Border.all(
      //               color: Colors.purple,
      //               width: 2, // Increase the border width
      //             )),
      //         child: Icon(
      //           Icons.person,
      //           size: 36, // Increase the icon size if necessary
      //         ),
      //       ),
      //       backgroundColor: Colors.white,
      //       elevation: 2,
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 8.0,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       IconButton(
      //         icon: Icon(
      //           Icons.home_rounded,
      //           color:
      //               _selectedIndex == 0 ? Colors.purple : Colors.grey.shade800,
      //         ),
      //         onPressed: () => _onIndexChange(0),
      //       ),
      //       IconButton(
      //         icon: Icon(
      //           Icons.calendar_month_rounded,
      //           color:
      //               _selectedIndex == 1 ? Colors.purple : Colors.grey.shade800,
      //         ),
      //         onPressed: () => _onIndexChange(1),
      //       ),
      //       SizedBox(width: 40),
      //       IconButton(
      //         icon: Icon(
      //           CupertinoIcons.chat_bubble_2,
      //           color:
      //               _selectedIndex == 2 ? Colors.purple : Colors.grey.shade800,
      //         ),
      //         onPressed: () => _onIndexChange(2),
      //       ),
      //       IconButton(
      //         icon: Icon(
      //           Icons.search_rounded,
      //           color:
      //               _selectedIndex == 3 ? Colors.purple : Colors.grey.shade800,
      //         ),
      //         onPressed: () => _onIndexChange(3),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
    Widget _buildTaskList() {
    if (_tasks.isEmpty) {
      return Center(
        child: Text(
          'No tasks available. Add a new task to get started.',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: ThemeColor.grey400,
            
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return ListTile(
          title: Text(
            task.title ?? '',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            task.description ?? '',
            style: GoogleFonts.poppins(
              fontSize: 14,
            ),
          ),
          trailing: Text(
            task.dateEnd ?? '',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
