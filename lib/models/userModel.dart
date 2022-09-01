class User {
  String? email;
  String? created_at;
  int? id;
  // String? email = null;
  // String? created_at = null;
  // int? id = null;
  User({
    this.email,
    this.created_at,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        created_at: json["created_at"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "created_at": created_at,
        "id": id,
      };
}
