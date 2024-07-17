import 'package:flutter/foundation.dart';

class Item {
  final String id;
  final String title;
  final String? description;
   int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  Item({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
    );
  }
}
