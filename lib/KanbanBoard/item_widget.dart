import 'package:flutter/material.dart';
import 'package:managerment/KanbanBoard/item.dart';
class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item}) : super(key: key);

  ListTile makeListTile(Item item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0, // Điều chỉnh cho giao diện di động
          vertical: 8.0,    // Điều chỉnh cho giao diện di động
        ),
        title: Text(
          item.title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.description != null)
              Text(
                item.description!,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            Text(
              "Status: ${item.status}",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            Text(
              "Updated At: ${item.updatedAt}",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            Text(
              "User ID: ${item.userId}",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.more_vert,
          color: Colors.black,
          size: 24.0, // Điều chỉnh cho giao diện di động
        ),
        onTap: () {},
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Điều chỉnh cho giao diện di động
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: makeListTile(item),
      ),
    );
  }
}
