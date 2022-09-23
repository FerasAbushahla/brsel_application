import 'dart:convert';

import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/models/registerModel.dart';
import 'package:brsel_application/service/apiSettings.dart';
import 'package:http/http.dart' as http;

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

  // static Future<Logout> logout({}){}
  static Future<List<HomeSlider>> getHomeSlider({String? access_token}) async {
    var response = await client.get(Uri.parse(ApiSettings.home), headers: {
      "Accept": "application/json",
      // "Accept-Encoding": "gzip, deflate, br",
      // "Content-Type": "application/json;charset=UTF-8",
      // "Charset": "utf-8",
      "Authorization": "Bearer $access_token"
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print('true getHomeSlider$jsonString');

      var mapOutput = json.decode(jsonString);
      print('true getHomeSlider mapOutput: $jsonString');

      // HomeSlider homeSlider = HomeSlider.fromJson(mapOutput);
      // print('true getHomeSlider homeSlider: $homeSlider');

      print(mapOutput['data']['sliders']);

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
      print('true getHomeCategories$jsonString');

      var mapOutput = json.decode(jsonString);
      print('true getHomeCategories mapOutput: $jsonString');

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
      print('false getHomeCategories body:$jsonString');

      var mapOutput = json.decode(jsonString);
      print('false getHomeCategories mapOutput: $jsonString');

      return [];
    }
  }
}
