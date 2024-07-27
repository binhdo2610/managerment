class Item {
  String? id;
  String? title;
  String? description;
  int? status;
  String? statusName;
  String? createdAt;
  String? updatedAt;
  String? expiredAt;
  String? userId;
  String? projectId;
  String? project;

  Item(
      {this.id,
      this.title,
      this.description,
      this.status,
      this.statusName,
      this.createdAt,
      this.updatedAt,
      this.expiredAt,
      this.userId,
      this.projectId,
      this.project});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    statusName = json['statusName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    expiredAt = json['expiredAt'];
    userId = json['userId'];
    projectId = json['projectId'];
    project = json['project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['statusName'] = this.statusName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['expiredAt'] = this.expiredAt;
    data['userId'] = this.userId;
    data['projectId'] = this.projectId;
    data['project'] = this.project;
    return data;
  }
}