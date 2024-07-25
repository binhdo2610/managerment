import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/AddNewTask/add_new_task.dart';
import 'package:managerment/ProjectPage/progress_cart.dart';
import 'package:managerment/api_services/task_service.dart';
import 'package:managerment/theme/app_theme.dart';

class ProjectDetail extends StatefulWidget {
  final String projectId;
  const ProjectDetail({Key? key, required this.projectId}) : super(key: key);

  @override
  State<ProjectDetail> createState() => _ProjectDetail();
}

class _ProjectDetail extends State<ProjectDetail> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    _fetchTodo();
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
              height: 40,
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      height: 550,
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return ProgressCart(
                            item: item,
                            onRefresh: _fetchTodo,
                            onEdit: () => navigateToEditPage(item),
                            onDelete: () => _deleteTodoById(item['id']),       
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchTodo() async {
    String projectId = widget.projectId;
    final fetchedItems = await TaskService.FetchTodo(
      projectId: projectId,
      context: context,
    );
    setState(() {
      items = fetchedItems;
      isLoading = false;
    });
  }

  Future<void> _deleteTodoById(String id) async {
    final isSuccess = await TaskService.deleteTodoById(id, context);
    if (isSuccess) {
      final filtered = items.where((element) => element['id'] != id).toList();
      setState(() {
        items = filtered;
      });
    }
  }
  void navigateToEditPage(Map item) {
    final route = MaterialPageRoute(
      builder: (context) => AddNewTask(todoList: item, projectId: widget.projectId,),
    );
    Navigator.push(context, route).then((_) => _fetchTodo());
  }
}
