import 'package:flutter/material.dart';
class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0, // Adjusted for mobile view
          vertical: 8.0,    // Adjusted for mobile view
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.sort,
          color: Colors.white,
          size: 24.0, // Adjusted for mobile view
        ),
        onTap: () {},
      ),
    );
  }
}
