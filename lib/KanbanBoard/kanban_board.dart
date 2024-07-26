import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:managerment/KanbanBoard/item.dart';
import 'package:managerment/KanbanBoard/item_widget.dart';
import 'package:managerment/api_services/kabanboard_service.dart';
import 'floating_widget.dart';

class KanbanBoard extends StatefulWidget {
  final double tileHeight = 100;
  final double headerHeight = 80;
  final double tileWidth = 250;
  final String projectId;

  const KanbanBoard({Key? key, required this.projectId}) : super(key: key);

  @override
  _KanbanState createState() => _KanbanState();
}

class _KanbanState extends State<KanbanBoard> {
  LinkedHashMap<int, List<Item>> board = LinkedHashMap();
  KanbanService _kanbanService = KanbanService();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      List<Item> planningItems = await _kanbanService.getToDoListByStatus(widget.projectId, 1);
      List<Item> inProgressItems = await _kanbanService.getToDoListByStatus(widget.projectId, 2);
      List<Item> completedItems = await _kanbanService.getToDoListByStatus(widget.projectId, 3);

      setState(() {
        board.addAll({
          1: planningItems,
          2: inProgressItems,
          3: completedItems,
        });
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(title: Text("Kanban Board")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: board.keys.map((int key) {
            return buildKanbanList(key, board[key]!);
          }).toList(),
        ),
      ),
    );
  }

  Widget buildKanbanList(int status, List<Item> items) {
    String listId = status == 1 ? "Planning" : (status == 2 ? "In Progress" : "Completed");

    return Container(
      margin: EdgeInsets.all(16),
      width: widget.tileWidth,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 169, 141, 141),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(listId),
          Expanded(
            child: DragTarget<Item>(
              onWillAccept: (data) {
                return true;
              },
              onAcceptWithDetails: (details)  async{
                setState(() {
                  Item receivedItem = details.data;
                  int oldStatus = receivedItem.status!;
                  receivedItem.status = status;
                  if(receivedItem.status == 2){
                    receivedItem.statusName = "In Progress";
                  }
                 if(receivedItem.status == 3){
                    receivedItem.statusName = "Complete";
                  }
                   _kanbanService.updateStatusToDoList(receivedItem.id!,receivedItem.title!,receivedItem.userId!,receivedItem.projectId!,receivedItem.description!,receivedItem.status!,receivedItem.statusName!,receivedItem.expiredAt!);
                  
                  board[oldStatus]!.remove(receivedItem);
                  board[status]!.add(receivedItem);
                });
              },
              onLeave: (data) {
                // Optional: Handle any clean up if needed
              },
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Draggable<Item>(
                      data: items[index],
                      child: ItemWidget(item: items[index]),
                      feedback: Material(
                        child: FloatingWidget(
                          child: ItemWidget(item: items[index]),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.2,
                        child: ItemWidget(item: items[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader(String listId) {
    return Container(
      height: widget.headerHeight,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          listId,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
