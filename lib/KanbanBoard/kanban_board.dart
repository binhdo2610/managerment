import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:managerment/KanbanBoard/item.dart';
import 'package:managerment/KanbanBoard/item_widget.dart';

import 'floating_widget.dart';



class KanbanBoard extends StatefulWidget {
  final double tileHeight = 100;
  final double headerHeight = 80;
  final double tileWidth = 250; // Adjusted for mobile view

  @override
  _KanbanState createState() => _KanbanState();
}

class _KanbanState extends State<KanbanBoard> {
  LinkedHashMap<String, List<Item>> board = LinkedHashMap();

  @override
void initState() {
  super.initState();
  board.addAll({
    "Planning": [
      Item(
        id: "1",
        listId: "Planning",
        title: "Email campaign",
        description: "Plan and execute an email marketing campaign",
        status: "Not started",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: "user1",
      ),
      Item(
        id: "2",
        listId: "Planning",
        title: "Apply for company transport ticket",
        description: "Get a transport ticket for commuting",
        status: "Not started",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: "user2",
      ),
    ],
    "In Progress": [
      Item(
        id: "3",
        listId: "In Progress",
        title: "Forward bank account details to HR",
        description: "Send the bank account details for salary processing",
        status: "In progress",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: "user3",
      ),
    ],
    "Completed": [
      Item(
        id: "4",
        listId: "Completed",
        title: "Pickup workplace hardware",
        description: "Collect the necessary hardware for work",
        status: "Completed",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: "user4",
      ),
      Item(
        id: "5",
        listId: "Completed",
        title: "Sign work contract",
        description: "Review and sign the employment contract",
        status: "Completed",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: "user5",
      ),
      Item(
        id: "6",
        listId: "Completed",
        title: "Send an intro message to everyone",
        description: "Introduce yourself to the team via email",
        status: "Completed",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: "user6",
      ),
    ],
  });
}

  buildItemDragTarget(String listId, int targetPosition, double height) {
    return DragTarget<Item>(
      onWillAccept: (Item? data) {
        return data != null && (board[listId]!.isEmpty || data.id != board[listId]![targetPosition].id);
      },
      onAccept: (Item data) {
        setState(() {
          board[data.listId]!.remove(data);
          data.listId = listId;
          if (board[listId]!.length > targetPosition) {
            board[listId]!.insert(targetPosition + 1, data);
          } else {
            board[listId]!.add(data);
          }
        });
      },
      builder: (BuildContext context, List<Item?> data, List<dynamic> rejectedData) {
        if (data.isEmpty) {
          return Container(
            height: height,
          );
        } else {
          return Column(
            children: [
              Container(
                height: height,
              ),
              ...data.map((Item? item) {
                if (item == null) return Container();
                return Opacity(
                  opacity: 0.5,
                  child: ItemWidget(item: item),
                );
              }).toList()
            ],
          );
        }
      },
    );
  }

  buildHeader(String listId) {
    Widget header = Container(
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
            fontSize: 16, // Adjusted for mobile view
          ),
        ),
      ),
    );

    return Stack(
      children: [
        Draggable<String>(
          data: listId,
          child: header,
          childWhenDragging: Opacity(
            opacity: 0.2,
            child: header,
          ),
          feedback: FloatingWidget(
            child: Container(
              width: widget.tileWidth,
              child: header,
            ),
          ),
        ),
        buildItemDragTarget(listId, 0, widget.headerHeight),
        DragTarget<String>(
          onWillAccept: (String? incomingListId) {
            return listId != incomingListId;
          },
          onAccept: (String incomingListId) {
            setState(
              () {
                LinkedHashMap<String, List<Item>> reorderedBoard = LinkedHashMap();
                for (String key in board.keys) {
                  if (key == incomingListId) {
                    reorderedBoard[listId] = board[listId]!;
                  } else if (key == listId) {
                    reorderedBoard[incomingListId] = board[incomingListId]!;
                  } else {
                    reorderedBoard[key] = board[key]!;
                  }
                }
                board = reorderedBoard;
              },
            );
          },
          builder: (BuildContext context, List<String?> data, List<dynamic> rejectedData) {
            if (data.isEmpty) {
              return Container(
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.blueAccent,
                  ),
                ),
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            }
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    buildKanbanList(String listId, List<Item> items) {
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
          children: [
            buildHeader(listId),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Draggable<Item>(
                      data: items[index],
                      child: ItemWidget(item: items[index]),
                      childWhenDragging: Opacity(
                        opacity: 0.2,
                        child: ItemWidget(item: items[index]),
                      ),
                      feedback: Container(
                        height: widget.tileHeight,
                        width: widget.tileWidth,
                        child: FloatingWidget(
                          child: ItemWidget(item: items[index]),
                        ),
                      ),
                    ),
                    buildItemDragTarget(listId, index, widget.tileHeight),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(title: Text("Kanban Board")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: board.keys.map((String key) {
              return buildKanbanList(key, board[key]!);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
