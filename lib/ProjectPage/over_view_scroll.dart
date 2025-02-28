import 'package:flutter/material.dart';
import 'package:managerment/ProjectPage/add_project.dart';
import 'package:managerment/ProjectPage/over_view_card.dart';
import 'package:managerment/api_services/project_service.dart';
import 'package:managerment/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class OverViewScroll extends StatefulWidget {
  const OverViewScroll({Key? key}) : super(key: key);

  @override
  State<OverViewScroll> createState() => _OverViewState();
}

class _OverViewState extends State<OverViewScroll> with TickerProviderStateMixin {
  late TabController tabController;

  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
    _fetchProject();
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
            labelColor: ThemeColor.dark1,
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ThemeColor.background,
              
            ),
            padding: EdgeInsets.all(10),
            unselectedLabelColor: ThemeColor.grey200,
            indicatorSize:  TabBarIndicatorSize.label,
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.myProject,
              ),
              Tab(
                text: AppLocalizations.of(context)!.inProgress,
              ),
              Tab(
                text: AppLocalizations.of(context)!.completed,
              ),
            ],
          ),
          Container(
            height: 250,
            width: double.maxFinite,
            child: TabBarView(
              controller: tabController,
              children: [
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final item = items[index];
                          return OverViewCard(
                            item: item,
                            onRefresh: _fetchProject,
                            onEdit: () => navigateToEditPage(item),
                            onDelete: () => _deleteById(item['id']),
                             // Pass the refresh callback
                          );
                        },
                      ),
                Text("Projects"),
                Text("Projects"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteById(String id) async {
    final isSuccess = await ProjectService.deleteById(id, context);
    if (isSuccess) {
      final filtered = items.where((element) => element['id'] != id).toList();
      setState(() {
        items = filtered;
      });
    }
  }

  Future<void> _fetchProject() async {
    final fetchedItems = await ProjectService.FetchProject();
    setState(() {
      items = fetchedItems;
      isLoading = false;
    });
  }

  void navigateToEditPage(Map item) {
    final route = MaterialPageRoute(
      builder: (context) => AddProjectScreen(toProject: item),
    );
    Navigator.push(context, route).then((_) => _fetchProject());
  }
}
