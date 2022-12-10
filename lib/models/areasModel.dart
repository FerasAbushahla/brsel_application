import 'dart:convert';

class AreasModel {
  Status? status;
  List<AreasDatum>? data;
  AreasModel({
    this.status,
    this.data,
  });

  factory AreasModel.fromJson(Map<String, dynamic> json) => AreasModel(
        status: Status.fromJson(json["status"]),
        data: List<AreasDatum>.from(
            json["data"].map((x) => AreasDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status!.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AreasDatum {
  int? id;
  String? value;
  AreasDatum({
    this.id,
    this.value,
  });

  factory AreasDatum.fromJson(Map<String, dynamic> json) => AreasDatum(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
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
