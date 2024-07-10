import 'package:flutter/material.dart';
import 'package:managerment/ProjectPage/over_view_card.dart';
import 'package:managerment/api_services/add_project_service.dart';


class OverView extends StatefulWidget {
  const OverView({Key? key}) : super(key: key);

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> with TickerProviderStateMixin {
  late TabController tabController;

  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
    _fetchTodo();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: tabController,
            labelColor: Colors.black,
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(0),
            unselectedLabelColor: Colors.grey.shade400,
            tabs: [
              Tab(
                text: "My Project",
              ),
              Tab(
                text: "In Progress",
              ),
              Tab(
                text: "Completed",
              ),
            ],
          ),
          Container(
            height: 250,
            width: double.maxFinite,
            child: TabBarView(
              controller: tabController,
              children: [
                ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return OverViewCard();
                    }),
                Text("Projects"),
                Text("Projects"),
              ],
            ),
          )
        ],
      ),
    );
  }
  Future<void> _fetchTodo() async {
    final fetchedItems = await AddProject.FetchTodo();
    setState(() {
      items = fetchedItems;
      isLoading = false;
    });
  }
}

class CircleTab extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return CirclePainter();
  }
}

class CirclePainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = Colors.black54;
    final Offset CirclePostion =
        Offset(configuration.size!.width - 3.0, configuration.size!.height / 2);
    canvas.drawCircle(offset + CirclePostion, 4, _paint);
  }
}