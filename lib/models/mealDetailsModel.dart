class MealDetailsModel {
  Status? status;
  MealDetailsData? data;
  MealDetailsModel({
    this.status,
    this.data,
  });

  factory MealDetailsModel.fromJson(Map<String, dynamic> json) =>
      MealDetailsModel(
        status: Status.fromJson(json["status"]),
        data: MealDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status!.toJson(),
        "data": data!.toJson(),
      };
}

class MealDetailsData {
  int? count;
  int? id;
  String? name;
  String? price;
  String? description;
  List<String>? extraIngredients;
  String? restaurant;
  String? category;
  String? review;
  String? deliveryTime;
  DateTime? createdAt;
  List<MealsDetailsExtra>? extras;
  List<Attachment>? attachments;
  MealDetailsData({
    this.count = 0,
    this.id,
    this.name,
    this.price,
    this.description,
    this.extraIngredients,
    this.restaurant,
    this.category,
    this.review,
    this.deliveryTime,
    this.createdAt,
    this.extras,
    this.attachments,
  });

  factory MealDetailsData.fromJson(Map<dynamic, dynamic> json) =>
      MealDetailsData(
        id: json["id"],
        count: json["count"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        extraIngredients:
            List<String>.from(json["extra_ingredients"].map((x) => x)),
        restaurant: json["restaurant"],
        category: json["category"],
        review: json["review"],
        deliveryTime: json["delivery_time"],
        createdAt: DateTime.parse(json["created_at"]),
        extras: List<MealsDetailsExtra>.from(
            json["extras"].map((x) => MealsDetailsExtra.fromJson(x))),
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "name": name,
        "price": price,
        "description": description,
        "extra_ingredients":
            List<dynamic>.from(extraIngredients!.map((x) => x)),
        "restaurant": restaurant,
        "category": category,
        "review": review,
        "delivery_time": deliveryTime,
        "created_at": createdAt!.toIso8601String(),
        "extras": List<dynamic>.from(extras!.map((x) => x.toJson())),
        "attachments": List<dynamic>.from(attachments!.map((x) => x.toJson())),
      };
}

class Attachment {
  String? name;
  String? order;
  String? link;
  Attachment({
    this.name,
    this.order,
    this.link,
  });

  factory Attachment.fromJson(Map<dynamic, dynamic> json) => Attachment(
        name: json["name"],
        order: json["order"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "order": order,
        "link": link,
      };
}

class MealsDetailsExtra {
  int? id;
  int? count;
  String? name;
  String? price;
  String? type;
  String? image;
  MealsDetailsExtra({
    this.id,
    this.count,
    this.name,
    this.price,
    this.type,
    this.image,
  });

  factory MealsDetailsExtra.fromJson(Map<dynamic, dynamic> json) =>
      MealsDetailsExtra(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        type: json["type"],
        image: json["image"],
        count: json["count"] == null ? 0 : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "type": type,
        "image": image,
        "count": count,
      };
}

class Status {
  bool? success;
  int? code;
  Status({
    this.success,
    this.code,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        success: json["success"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
      };
}
