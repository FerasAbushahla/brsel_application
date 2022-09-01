import 'dart:convert';

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
}
