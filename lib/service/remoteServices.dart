import 'dart:convert';
import 'dart:io';

import 'package:brsel_application/models/SearchModel.dart';
import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/models/mealDetailsModel.dart';
import 'package:brsel_application/models/orderHistoryModel.dart';
import 'package:brsel_application/models/orderModel.dart';
import 'package:brsel_application/models/personalInfoModel.dart';
import 'package:brsel_application/models/registerModel.dart';
import 'package:brsel_application/service/apiSettings.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<RegisterModel> register({
    String? email,
    String? password,
  }) async {
    print('$email + $password');
    var response = await client.post(
      Uri.parse(ApiSettings.register),
      body: {
        "email": email,
        "password": password,
      },
      // body: jsonEncode({
      //   "email": email,
      //   "password": password,
      // }),
      // headers: {
      //   "Accept-Encoding": "gzip, deflate, br",
      //   "Connection": "keep-alive",
      //   "Accept": "application/json",
      // },
    );
    print(response);

    print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);

      var mapOutput = await json.decode(jsonString);
      print(mapOutput);

      RegisterModel registerResponse = RegisterModel.fromJson(mapOutput);
      return registerResponse;
    } else if (response.statusCode == 401) {
      var jsonString = response.body;
      print(jsonString);

      var mapOutput = await json.decode(jsonString);
      // print(mapOutput);
      // print(mapOutput['status']);
      // print(mapOutput['errors']['email']);
      // var status = mapOutput['status'];
      // var message = mapOutput['errors']['email'].toString();
      RegisterModel registerResponse = RegisterModel.fromJson(mapOutput);
      return registerResponse;
      // return registerResponse.status = status;
      // return RegisterModel(status: status, message: message);
      // throw Exception();
      // throw Exception('Error occured in registering these credntials');
    } else {
      var jsonString = response.body;
      print(jsonString);
      var mapOutput = await json.decode(jsonString);
      RegisterModel registerResponse = RegisterModel.fromJson(mapOutput);
      return registerResponse;
    }
  }

  static Future logout({
    String? access_token,
  }) async {
    print('token...$access_token');

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
      "Authorization": "Bearer $access_token"
    };
    var response = await client.post(
      Uri.parse(ApiSettings.logout),
      headers: headers,
    );
    print(response);

    print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);

      var mapOutput = await json.decode(jsonString)["message"];
      print(mapOutput);

      return mapOutput;
    } else {
      var jsonString = response.body;
      print(jsonString);

      var mapOutput = await json.decode(jsonString)["message"];
      print(mapOutput);

      return mapOutput;
    }
  }

  static Future<PersonalInfoModel> login({
    required String email,
    required String password,
  }) async {
    // print('token...$access_token');

    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      "Accept": "application/json",
      // "Authorization": "Bearer $access_token"
    };
    Map<String, String> body = {
      "email": email,
      "password": password,
    };
    var response = await client.post(
      Uri.parse(ApiSettings.login),
      headers: headers,
      body: body,
    );
    print('login');
    print(response);

    print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);

      var mapOutput = await json.decode(jsonString);
      print(mapOutput);

      PersonalInfoModel personalInfoResponse =
          PersonalInfoModel.fromJson(mapOutput);

      return personalInfoResponse;
    } else {
      print('login error');
      var jsonString = response.body;
      print(jsonString);

      var mapOutput = await json.decode(jsonString);
      print(mapOutput);

      PersonalInfoModel personalInfoResponse =
          PersonalInfoModel.fromJson(mapOutput);

      return personalInfoResponse;
    }
  }

  static Future<PersonalInfoModel> userInfoRegister(
      {String? userID,
      String? firstName,
      String? lastName,
      String? phoneNumber,
      String? gender,
      File? image,
      String? address,
      String? lat,
      String? long,
      String? access_token}) async {
    print(
        '$firstName + $lastName + $phoneNumber + $gender+ $image + $lat+ $long');
    var request =
        http.MultipartRequest("POST", Uri.parse(ApiSettings.infoRegister));

    Map<String, String> body = {
      "id": userID!,
      "first_name": firstName!,
      "last_name": lastName!,
      "phone": phoneNumber!,
      "gender": gender!,
      "address": address!,
      "latitude": lat!,
      "longitude": long!,
    };
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
      "Authorization": "Bearer $access_token"
    };
    request.headers.addAll(headers);
    request.fields.addAll(body);
    if (image != null) {
      String fileName = image.path.split("/").last;
      var stream = http.ByteStream(DelegatingStream(image.openRead()));
      var length = await image.length();
      var multipartFile =
          http.MultipartFile("avatar", stream, length, filename: fileName);

      request.files.add(multipartFile);
    }

    http.Response response =
        await http.Response.fromStream(await request.send());
    var output = json.decode(response.body);
    print(output);

    print(response);

    print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);

      var mapOutput = await json.decode(jsonString);
      print(mapOutput);

      PersonalInfoModel personalInfoResponse =
          PersonalInfoModel.fromJson(mapOutput);
      return personalInfoResponse;
    } else {
      var jsonString = response.body;
      print(jsonString);
      var mapOutput = await json.decode(jsonString);
      PersonalInfoModel personalInfoResponse =
          PersonalInfoModel.fromJson(mapOutput);
      print(mapOutput);
      return personalInfoResponse;
    }
  }
  // static Future<PersonalInfoModel> userInfoRegister({
  //   String? userID,
  //   String? firstName,
  //   String? lastName,
  //   String? phoneNumber,
  //   String? gender,
  //   File? image,
  //   String? address,
  //   String? lat,
  //   String? long,
  // }) async {
  //   print(
  //       '$firstName + $lastName + $phoneNumber + $gender+ $image + $lat+ $long');
  //   var response = await client.post(
  //     Uri.parse(ApiSettings.infoRegister),
  //     body: {
  //       "id": userID,
  //       "first_name": firstName,
  //       "last_name": lastName,
  //       "phone": phoneNumber,
  //       "image": image,
  //       "gender": gender,
  //       "address": address,
  //       "latitude": lat,
  //       "longitude": long,
  //     },
  //   );
  //   print(response);

  //   print(response.statusCode);

  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     print(jsonString);

  //     var mapOutput = await json.decode(jsonString);
  //     print(mapOutput);

  //     PersonalInfoModel personalInfoResponse =
  //         PersonalInfoModel.fromJson(mapOutput);
  //     return personalInfoResponse;
  //   } else {
  //     var jsonString = response.body;
  //     print(jsonString);
  //     var mapOutput = await json.decode(jsonString);
  //     PersonalInfoModel personalInfoResponse =
  //         PersonalInfoModel.fromJson(mapOutput);
  //     print(mapOutput);
  //     return personalInfoResponse;
  //   }
  // }

  static Future<List<HomeSlider>> getHomeSlider({String? access_token}) async {
    var response = await client.get(Uri.parse(ApiSettings.home), headers: {
      "Accept": "application/json",
      // "Accept-Encoding": "gzip, deflate, br",
      // "Content-Type": "application/json;charset=UTF-8",
      // "Charset": "utf-8",
      "Authorization": "Bearer $access_token"
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // print('true getHomeSlider$jsonString');

      var mapOutput = json.decode(jsonString);
      // print('true getHomeSlider mapOutput: $jsonString');

      // HomeSlider homeSlider = HomeSlider.fromJson(mapOutput);
      // print('true getHomeSlider homeSlider: $homeSlider');

      // print(mapOutput['data']['sliders']);

      // print((mapOutput['data']['sliders'])
      //     .map((e) => HomeSlider.fromJson(e))
      //     .cast<HomeSlider>()
      //     .toList());

      return (mapOutput['data']['sliders'])
          .map((e) => HomeSlider.fromJson(e))
          .cast<HomeSlider>()
          .toList();
    } else {
      var jsonString = response.body;
      // print('false getHomeSlider body:$jsonString');

      var mapOutput = json.decode(jsonString);
      // print('false getHomeSlider mapOutput: $jsonString');

      // HomeModelData homeModelData = HomeModelData.fromJson(mapOutput);
      // print('false getHomeSlider homeModelData: $homeModelData');
      return [];
    }
  }

  static Future<List<HomeResturante>> getHomeRestaurants(
      {String? access_token}) async {
    var response = await client.get(Uri.parse(ApiSettings.home), headers: {
      "Accept": "application/json",
      // "Accept-Encoding": "gzip, deflate, br",
      // "Content-Type": "application/json;charset=UTF-8",
      // "Charset": "utf-8",
      "Authorization": "Bearer $access_token"
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // print('true getHomeRestaurants$jsonString');

      var mapOutput = json.decode(jsonString);
      // print('true getHomeRestaurants mapOutput: $jsonString');

      // print((mapOutput['data']['resturantes'])
      //     .map((e) => HomeResturante.fromJson(e))
      //     .cast<HomeResturante>()
      //     .toList());

      return (mapOutput['data']['resturantes'])
          .map((e) => HomeResturante.fromJson(e))
          .cast<HomeResturante>()
          .toList();
    } else {
      var jsonString = response.body;
      // print('false getHomeRestaurants body:$jsonString');

      var mapOutput = json.decode(jsonString);
      // print('false getHomeRestaurants mapOutput: $jsonString');

      return [];
    }
  }

  static Future<List<HomeCategories>> getHomeCategories(
      {String? access_token}) async {
    var response = await client.get(Uri.parse(ApiSettings.home), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $access_token"
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // print('true getHomeCategories$jsonString');

      var mapOutput = json.decode(jsonString);
      // print('true getHomeCategories mapOutput: $jsonString');

      // print((mapOutput['data']['resturantes'])
      //     .map((e) => HomeResturante.fromJson(e))
      //     .cast<HomeResturante>()
      //     .toList());

      return (mapOutput['data']['categories'])
          .map((e) => HomeCategories.fromJson(e))
          .cast<HomeCategories>()
          .toList();
    } else {
      var jsonString = response.body;
      // print('false getHomeCategories body:$jsonString');

      var mapOutput = json.decode(jsonString);
      // print('false getHomeCategories mapOutput: $jsonString');

      return [];
    }
  }

  static Future<List<HomeMeals>> getHomeMeals({String? access_token}) async {
    var response = await client.get(Uri.parse(ApiSettings.home), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $access_token"
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // print('true getHomeMeals$jsonString');

      var mapOutput = json.decode(jsonString);
      // print('true getHomeMeals mapOutput: $jsonString');

      // print((mapOutput['data']['resturantes'])
      //     .map((e) => HomeResturante.fromJson(e))
      //     .cast<HomeResturante>()
      //     .toList());

      return (mapOutput['data']['meals'])
          .map((e) => HomeMeals.fromJson(e))
          .cast<HomeMeals>()
          .toList();
    } else {
      var jsonString = response.body;
      // print('false getHomeMeals body:$jsonString');

      var mapOutput = json.decode(jsonString);
      // print('false getHomeMeals mapOutput: $jsonString');

      return [];
    }
  }

  static Future<MealDetailsData> getMealDetails(
      {String? access_token, String? mealID}) async {
    print('mealID...$mealID');
    print('${ApiSettings.mealDetails}/$mealID');
    var response = await client
        .get(Uri.parse('${ApiSettings.mealDetails}/$mealID'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $access_token"
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // print('true getHomeMeals$jsonString');

      var mapOutput = json.decode(jsonString)['data'];
      print('true getMealDetails mapOutput: $jsonString');

      MealDetailsData mealDetailsData = MealDetailsData.fromJson(mapOutput);
      print('data  ${mealDetailsData.toJson()}');
      print(mealDetailsData.toJson());
      print('the end');

      return mealDetailsData;
    } else {
      var jsonString = response.body;
      print('false getMealDetails body:$jsonString');

      var mapOutput = json.decode(jsonString);
      MealDetailsData mealDetailsData = MealDetailsData.fromJson(mapOutput);
      // print('false getHomeMeals mapOutput: $jsonString');

      return mealDetailsData;
    }
  }

  static Future<List<SearchData>> getSearchMeals(
      {String? access_token, String? searchWord}) async {
    print('${ApiSettings.search}$searchWord');
    var response = await client
        .get(Uri.parse('${ApiSettings.search}$searchWord'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $access_token"
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // print('true getHomeMeals$jsonString');q

      var mapOutput = json.decode(jsonString);
      print('true getSearchMeals mapOutput: $jsonString');

      // print((mapOutput['data']['resturantes'])
      //     .map((e) => HomeResturante.fromJson(e))
      //     .cast<HomeResturante>()
      //     .toList());

      return (mapOutput['data'])
          .map((e) => SearchData.fromJson(e))
          .cast<SearchData>()
          .toList();
    } else {
      var jsonString = response.body;
      // print('false getHomeMeals body:$jsonString');

      var mapOutput = json.decode(jsonString);
      // print('false getHomeMeals mapOutput: $jsonString');

      return [];
    }
  }

  static Future contacUs({
    required String userID,
    required String message,
    required File file,
    required String access_token,
  }) async {
    var request =
        http.MultipartRequest("POST", Uri.parse(ApiSettings.contactUs));

    Map<String, String> body = {
      "user_id": userID,
      "message": message,
    };
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
      "Authorization": "Bearer $access_token"
    };
    request.headers.addAll(headers);
    request.fields.addAll(body);
    if (file != null) {
      String fileName = file.path.split("/").last;
      var stream = http.ByteStream(DelegatingStream(file.openRead()));
      var length = await file.length();
      var multipartFile =
          http.MultipartFile("file", stream, length, filename: fileName);

      request.files.add(multipartFile);
    }

    http.Response response =
        await http.Response.fromStream(await request.send());

    var output = json.decode(response.body);
    print(output);

    print(response);

    print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);

      var mapOutput = await json.decode(jsonString)["message"];
      print(mapOutput);
      return mapOutput;
    } else {
      var jsonString = response.body;
      print(jsonString);

      var mapOutput = await json.decode(jsonString)["message"];
      print(mapOutput);

      return mapOutput;
    }
  }

  static Future order(
      {required OrderModel orderModel, String? access_token}) async {
    print('$orderModel+ $access_token');
    var body = jsonEncode(orderModel.toJson());
    print('body $body');
    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      "Accept": "application/json",
      "Authorization": "Bearer $access_token",
      "Content-Type": "application/json",
    };

    var response = await client.post(
      Uri.parse(ApiSettings.Order),
      headers: headers,
      body: body,
    );
    print('order');
    print(response);

    print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);

      var mapOutput = await json.decode(jsonString)["message"];
      print(mapOutput);

      return mapOutput;
    } else {
      // var jsonString = response.body;
      // print(jsonString);

      // var mapOutput = await json.decode(jsonString)["message"];
      // print(mapOutput);

      return response;
    }
  }

  static Future<OrderHistoryModel?> getOrdersHistory(
      {String? access_token}) async {
    print('${ApiSettings.Orders}');
    var response = await client.get(Uri.parse('${ApiSettings.Orders}'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $access_token"
        });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print('$jsonString');

      var mapOutput = json.decode(jsonString);
      print('jsonString');

      return OrderHistoryModel.fromJson(mapOutput);
    }
    return null;
  }

  static Future<Datum?> getOrderDetails(
      {String? access_token, int? orderID}) async {
    print('${ApiSettings.Orders}');
    var response = await client.get(Uri.parse('${ApiSettings.Order}/$orderID'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $access_token"
        });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print('$jsonString');

      var mapOutput = json.decode(jsonString);
      print('jsonString');

      return Datum.fromJson(mapOutput['data']);
    }
    return null;
  }
}
