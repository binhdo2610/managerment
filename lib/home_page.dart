import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:managerment/ChatPage/chat_page.dart';
import 'package:managerment/ProjectPage/project_detail.dart';
import 'package:managerment/ProjectPage/project_page.dart';
import 'package:managerment/TaskPage/task_page.dart';
import 'package:managerment/model/task_model.dart';
import 'ChatPage/home_page.dart';

class HomePage extends StatefulWidget {
  final String fullname;
  const HomePage({Key? key, required this.fullname}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onIndexChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: Navigator(
              onGenerateRoute: (setting){
                Widget page = ProjectPage(username: '');
                if(setting.name == 'ProjectDetail'){
                  page = ProjectDetail();
                  return MaterialPageRoute(builder: (_) => page);
                }
                else{
                  return MaterialPageRoute(
                  builder: (context) => ProjectPage(username: widget.fullname));
                }
              },
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: Navigator(
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => TaskPage(Goback: (int index) {}),
                );
              },
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: Navigator(
              onGenerateRoute: (routeSettings) {    
                return MaterialPageRoute(
                  builder: (context) => HomeChatPage(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: isKeyboardOpen
          ? null
          : ClipOval(
              child: Container(
                width: 85,  // Increase the width
                height: 85,  // Increase the height
                child: FloatingActionButton(
                  onPressed: () {
                    // showModalBottomSheet(context: , builder: )
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,  // Increase the border width
                      )
                    ),
                    child: Icon(
                      Icons.person,
size: 36,  // Increase the icon size if necessary
                    ),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 2,
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.home_rounded,
                color: _selectedIndex == 0 ? Colors.purple : Colors.grey.shade800,
              ),
              onPressed: () => _onIndexChange(0),
            ),
            IconButton(
              icon: Icon(
                Icons.calendar_month_rounded,
                color: _selectedIndex == 1 ? Colors.purple : Colors.grey.shade800,
              ),
              onPressed: () => _onIndexChange(1),
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(
                CupertinoIcons.chat_bubble_2,
                color: _selectedIndex == 2 ? Colors.purple : Colors.grey.shade800,
              ),
              onPressed: () => _onIndexChange(2),
            ),
            IconButton(
              icon: Icon(
                Icons.search_rounded,
                color: _selectedIndex == 3 ? Colors.purple : Colors.grey.shade800,
              ),
              onPressed: () => _onIndexChange(3),
            ),
          ],
        ),
      ),
    );
  }
}