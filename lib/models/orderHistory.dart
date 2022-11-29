class OrderHistory {
  Status? status;
  List<Datum>? data;
  OrderHistory({
    this.status,
    this.data,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
        status: Status.fromJson(json["status"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status!.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? deliveryTime;
  String? status;
  String? totalPrice;
  List<MealElement>? meals;
  Datum({
    this.id,
    this.deliveryTime,
    this.status,
    this.totalPrice,
    this.meals,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        deliveryTime: json["delivery_time"],
        status: json["status"],
        totalPrice: json["total_price"],
        meals: List<MealElement>.from(
            json["meals"].map((x) => MealElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_time": deliveryTime,
        "status": status,
        "total_price": totalPrice,
        "meals": List<dynamic>.from(meals!.map((x) => x.toJson())),
      };
}

class MealElement {
  int? id;
  String? numberOfMeals;
  String? totalPrice;
  MealMeal? meal;
  MealElement({
    this.id,
    this.numberOfMeals,
    this.totalPrice,
    this.meal,
  });

  factory MealElement.fromJson(Map<String, dynamic> json) => MealElement(
        id: json["id"],
        numberOfMeals: json["number_of_meals"],
        totalPrice: json["total_price"],
        meal: MealMeal.fromJson(json["meal"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number_of_meals": numberOfMeals,
        "total_price": totalPrice,
        "meal": meal!.toJson(),
      };
}

class MealMeal {
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
  List<Extra>? extras;
  List<Attachment>? attachments;
  MealMeal({
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

  factory MealMeal.fromJson(Map<String, dynamic> json) => MealMeal(
        id: json["id"],
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
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
  Attachment({
    this.name,
    this.order,
    this.link,
  });

  String? name;
  String? order;
  String? link;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
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

class Extra {
  int? id;
  String? name;
  String? price;
  String? type;
  dynamic? image;
  Extra({
    this.id,
    this.name,
    this.price,
    this.type,
    this.image,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        type: json["type"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "type": type,
        "image": image,
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
