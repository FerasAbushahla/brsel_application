class HomeModel {
  Status? status;
  HomeModelData? data;
  HomeModel({
    this.status,
    this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: Status.fromJson(json["status"]),
        data: HomeModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status!.toJson(),
        "data": data!.toJson(),
      };
}

class HomeModelData {
  List<HomeSlider>? sliders;
  List<HomeResturante>? resturantes;
  List<HomeMeals>? meals;
  List<HomeCategories>? categories;
  HomeModelData({
    this.sliders,
    this.resturantes,
    this.meals,
    this.categories,
  });

  factory HomeModelData.fromJson(Map<String, dynamic> json) => HomeModelData(
        sliders: List<HomeSlider>.from(
            json["sliders"].map((x) => HomeSlider.fromJson(x))),
        resturantes: List<HomeResturante>.from(
            json["resturantes"].map((x) => HomeResturante.fromJson(x))),
        meals: List<HomeMeals>.from(
            json["meals"].map((x) => HomeMeals.fromJson(x))),
        categories: List<HomeCategories>.from(
            json["categories"].map((x) => HomeCategories.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sliders": List<dynamic>.from(sliders!.map((x) => x.toJson())),
        "resturantes": List<dynamic>.from(resturantes!.map((x) => x.toJson())),
        "meals": List<dynamic>.from(meals!.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class HomeCategories {
  int? id;
  String? name;
  HomeCategories({
    this.id,
    this.name,
  });

  factory HomeCategories.fromJson(Map<String, dynamic> json) => HomeCategories(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class HomeMeals {
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
  List<HomeMealsExtra>? extras;
  List<Attachment>? attachments;
  HomeMeals({
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

  factory HomeMeals.fromJson(Map<String, dynamic> json) => HomeMeals(
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
        extras: List<HomeMealsExtra>.from(
            json["extras"].map((x) => HomeMealsExtra.fromJson(x))),
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
  String? name;
  String? order;
  String? link;
  Attachment({
    this.name,
    this.order,
    this.link,
  });

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

class HomeMealsExtra {
  int? id;
  String? name;
  String? price;
  String? type;
  HomeMealsExtra({
    this.id,
    this.name,
    this.price,
    this.type,
  });

  factory HomeMealsExtra.fromJson(Map<String, dynamic> json) => HomeMealsExtra(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "type": type,
      };
}

class HomeResturante {
  int? id;
  String? name;
  String? description;
  String? address;
  String? latitude;
  String? longitude;
  String? phone;
  String? active;
  String? deliveryTime;
  String? review;
  String? image;
  DateTime? createdAt;
  HomeResturante({
    this.id,
    this.name,
    this.description,
    this.address,
    this.latitude,
    this.longitude,
    this.phone,
    this.active,
    this.deliveryTime,
    this.review,
    this.image,
    this.createdAt,
  });

  factory HomeResturante.fromJson(Map<String, dynamic> json) => HomeResturante(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        address: json["address"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        phone: json["phone"],
        active: json["active"],
        deliveryTime: json["delivery_time"],
        review: json["review"],
        // image: json["image"],
        image: json["image"] == null ? null : json["image"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "address": address,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "phone": phone,
        "active": active,
        "delivery_time": deliveryTime,
        "review": review,
        "image": image == null ? null : image,
        "created_at": createdAt!.toIso8601String(),
      };
}

class HomeSlider {
  int? id;
  String? name;
  String? orderIndex;
  dynamic? status;
  dynamic? image;
  HomeSlider({
    this.id,
    this.name,
    this.orderIndex,
    this.status,
    this.image,
  });

  factory HomeSlider.fromJson(Map<String, dynamic> json) => HomeSlider(
        id: json["id"],
        name: json["name"],
        orderIndex: json["order_index"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "order_index": orderIndex,
        "status": status,
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
