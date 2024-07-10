import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/ProjectPage/add_project.dart';
import 'package:managerment/api_services/add_project_service.dart';
import 'package:managerment/api_services/base_api.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
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
        title: Text('Test'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Visibility(
              visible: isLoading,
              child: Center(child: CircularProgressIndicator(),),
              replacement: RefreshIndicator(
                onRefresh: _fetchTodo,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final id = item['id'] as String;
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text("${index + 1}"),
                      ),
                      title: Text(item['title']),
                      trailing: PopupMenuButton(
                        onSelected: (value){
                          if(value == 'edit'){
                            navigateToEditPage(item);
                          }else if(value == 'delete'){
                            _deleteById(id, context);
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: Text(
                                'Edit',
                                style: GoogleFonts.poppins(),
                              ),
                              value: 'edit',
                            ),
                            PopupMenuItem(
                              child: Text(
                                'Delete',
                                style: GoogleFonts.poppins(),
                              ),
                              value: 'delete',
                            ),
                          ];
                        },
                      ),
                    );
                  },   
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteById(String id, BuildContext context) async {
   final isSucces = await AddProject.deleteById(id, context);
   if(isSucces) {
    final filtered = items.where((element) => element['id'] != id).toList();
    setState(() {
      items = filtered;
    });
   }
    
  }

  Future<void> _fetchTodo() async {
    final fetchedItems = await AddProject.FetchTodo();
    setState(() {
      items = fetchedItems;
      isLoading = false;
    });
  }
   Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddProjectScreen(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    _fetchTodo();
  }

  void navigateToEditPage(Map item){
    final route = MaterialPageRoute(
      builder: (context) => AddProjectScreen(toProject: item,),
    );
    Navigator.push(context, route);
  }
}
