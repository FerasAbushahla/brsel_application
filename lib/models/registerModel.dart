import 'package:brsel_application/models/userModel.dart';

class RegisterModel {
  bool? status;
  String? message;
  String? token;
  User? user;
  Errors? errors;
  RegisterModel({
    this.status,
    this.message,
    this.token,
    this.user,
    this.errors,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "user": user?.toJson(),
        "errors": errors?.toJson(),
      };
}

class Errors {
  List<String>? email;

  Errors({
    this.email,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: List<String>.from(json["email"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from(email!.map((x) => x)),
      };
}
