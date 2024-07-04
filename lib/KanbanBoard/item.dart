class Item {
  final String id;
  String listId;
  final String title;
  final String? description;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  Item({
    required this.id,
    required this.listId,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });
}
