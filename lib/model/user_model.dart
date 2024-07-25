class UserModel {
  String? id;
  String? email;
  String? username;
  String? firstname;
  String? lastname;
  Null? avatar;
  Null? phone;
  String? password;
  Null? projectUsers;

  UserModel(
      {this.id,
      this.email,
      this.username,
      this.firstname,
      this.lastname,
      this.avatar,
      this.phone,
      this.password,
      this.projectUsers});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    avatar = json['avatar'];
    phone = json['phone'];
    password = json['password'];
    projectUsers = json['projectUsers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['projectUsers'] = this.projectUsers;
    return data;
  }
}