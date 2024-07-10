import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managerment/KanbanBoard/kanban_board.dart';
import 'package:managerment/theme/app_theme.dart';

class OverViewCard extends StatelessWidget {
  final Map item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onRefresh;

  const OverViewCard({
    Key? key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KanbanBoard()),
        );
        onRefresh();
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.fromLTRB(0, 5, 20, 5),
        width: 180,
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: ThemeColor.primary,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.code,
                      color: ThemeColor.background,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item['title'],
                    style: GoogleFonts.poppins(color: ThemeColor.background),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    onEdit();
                    onRefresh();
                  },
                  child: Icon(Icons.edit),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    onDelete();
                    onRefresh();
                  },
                  child: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: ThemeColor.primaryLight1,
        ),
      ),
    );
  }
}