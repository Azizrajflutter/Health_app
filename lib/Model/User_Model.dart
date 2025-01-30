import 'dart:convert';

class UserModel {
  final User user;
  final String token;

  UserModel({
    required this.user,
    required this.token,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String userType;
  final int isActive;
  final int id;

  User({
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.userType,
    required this.isActive,
    required this.id,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        fName: json["f_name"],
        lName: json["l_name"],
        email: json["email"],
        phone: json["phone"],
        userType: json["user_type"],
        isActive: json["is_active"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "phone": phone,
        "user_type": userType,
        "is_active": isActive,
        "id": id,
      };
}
