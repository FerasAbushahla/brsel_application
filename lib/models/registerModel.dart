import 'package:brsel_application/models/userModel.dart';

class RegisterModel {
  bool? status;
  String? message;
  String? token;
  User? user;
  RegisterModel({
    this.status,
    this.message,
    this.token,
    this.user,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "user": user?.toJson(),
      };
}
