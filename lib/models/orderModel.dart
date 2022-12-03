import 'dart:convert';

class OrderModel {
  String? paymentWay;
  String? status;
  String? notes;
  List<Meal>? meals;

  OrderModel({
    this.paymentWay,
    this.status,
    this.notes,
    this.meals,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        paymentWay: json["payment_way"],
        status: json["status"],
        notes: json["notes"],
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payment_way": paymentWay,
        "status": status,
        "notes": notes,
        "meals": List<dynamic>.from(meals!.map((x) => x.toJson())),
      };
}

class Meal {
  int? mealId;
  int? numberOfMeals;
  List<Extra>? extras;
  // List<MealExtras>? mealExtras;
  List<String>? meal_extras;
  Meal({
    this.mealId,
    this.numberOfMeals,
    this.extras,
    this.meal_extras,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        mealId: json["meal_id"],
        numberOfMeals: json["number_of_meals"],
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
        meal_extras: List<String>.from(json["meal_extras"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "meal_id": mealId,
        "number_of_meals": numberOfMeals,
        "extras": List<dynamic>.from(extras!.map((x) => x.toJson())),
        "meal_extras": List<dynamic>.from(meal_extras!.map((x) => x)),
      };
}

class Extra {
  int? id;
  String? name;
  int? count;

  Extra({
    this.id,
    this.name,
    this.count,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "count": count,
      };
}
