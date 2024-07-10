import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:managerment/KanbanBoard/kanban_board.dart';

class OverViewCard extends StatefulWidget {
  const OverViewCard({Key? key}) : super(key: key);

  @override
  State<OverViewCard> createState() => _OverViewCardState();
}

class _OverViewCardState extends State<OverViewCard> {
  TextEditingController title = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KanbanBoard()),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.fromLTRB(0, 5, 20, 5),
        width: 180,
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 123, 0, 245),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Icon(
                    CupertinoIcons.person,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap:(){},
                  child: Icon(Icons.edit),
                ),
                GestureDetector(
                  onTap:(){},
                  child: Icon(Icons.delete),
                ),
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color.fromARGB(150, 123, 0, 245)),
      ),
    );
  }
}
