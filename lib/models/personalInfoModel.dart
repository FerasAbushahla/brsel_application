class PersonalInfoModel {
  bool? status;
  String? message;
  User? user;
  String? token;

  PersonalInfoModel({
    this.status,
    this.message,
    this.user,
    this.token,
  });

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) =>
      PersonalInfoModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "user": user!.toJson(),
      };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  dynamic avatar;
  String? gender;
  String? email;
  String? address;
  String? latitude;
  String? longitude;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  dynamic deletedAt;
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.avatar,
    this.gender,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.emailVerifiedAt,
    this.createdAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        avatar: json["avatar"],
        gender: json["gender"],
        email: json["email"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "avatar": avatar,
        "gender": gender,
        "email": email,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt!.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
