import 'dart:convert';

class OrderModel {
  int? totalPrice;
  String? paymentWay;
  int? userId;
  String? status;
  List<Meal>? meals;
  OrderModel({
    this.totalPrice,
    this.paymentWay,
    this.userId,
    this.status,
    this.meals,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        totalPrice: json["total_price"],
        paymentWay: json["payment_way"],
        userId: json["user_id"],
        status: json["status"],
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_price": totalPrice,
        "payment_way": paymentWay,
        "user_id": userId,
        "status": status,
        "meals": List<dynamic>.from(meals!.map((x) => x.toJson())),
      };
}

class Meal {
  int? mealId;
  int? numberOfMeals;
  int? totalPrice;
  List<Extra>? extras;
  List<Extra>? mealExtras;
  Meal({
    this.mealId,
    this.numberOfMeals,
    this.totalPrice,
    this.extras,
    this.mealExtras,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        mealId: json["meal_id"],
        numberOfMeals: json["number_of_meals"],
        totalPrice: json["total_price"],
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
        mealExtras:
            List<Extra>.from(json["meal_extras"].map((x) => Extra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meal_id": mealId,
        "number_of_meals": numberOfMeals,
        "total_price": totalPrice,
        "extras": List<dynamic>.from(extras!.map((x) => x.toJson())),
        "meal_extras": List<dynamic>.from(mealExtras!.map((x) => x.toJson())),
      };
}

class Extra {
  int? id;
  String? name;
  Extra({
    this.id,
    this.name,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
