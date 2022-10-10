import 'dart:convert';
import 'dart:io';

import 'package:brsel_application/models/SearchModel.dart';
import 'package:brsel_application/models/homeModel.dart';
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
          http.MultipartFile('image', stream, length, filename: fileName);

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

  // static Future<Logout> logout({}){}
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

  // static Future<List<HomeMeals>> getMealDetails(
  //     {String? access_token, int? mealID}) async {
  //   var response = await client.get(Uri.parse('${ApiSettings.meals}/$mealID'),
  //       headers: {
  //         "Accept": "application/json",
  //         "Authorization": "Bearer $access_token"
  //       });
  //   // print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     // print('true getHomeMeals$jsonString');

  //     var mapOutput = json.decode(jsonString);
  //     // print('true getHomeMeals mapOutput: $jsonString');

  //     // print((mapOutput['data']['resturantes'])
  //     //     .map((e) => HomeResturante.fromJson(e))
  //     //     .cast<HomeResturante>()
  //     //     .toList());

  //     return (mapOutput['data']['meals'])
  //         .map((e) => HomeMeals.fromJson(e))
  //         .cast<HomeMeals>()
  //         .toList();
  //   } else {
  //     var jsonString = response.body;
  //     // print('false getHomeMeals body:$jsonString');

  //     var mapOutput = json.decode(jsonString);
  //     // print('false getHomeMeals mapOutput: $jsonString');

  //     return [];
  //   }
  // }
  static Future<List<SearchData>> getSearchMeals(
      {String? access_token, String? searchWord}) async {
    print('${ApiSettings.search}?$searchWord');
    var response = await client
        .get(Uri.parse('${ApiSettings.search}$searchWord'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $access_token"
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // print('true getHomeMeals$jsonString');

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
}
