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
    } else {
      var jsonString = response.body;
      print(jsonString);

      var mapOutput = await json.decode(jsonString);
      print(mapOutput);
      // throw Exception();
      throw Exception('Error occured in registering these credntials');
    }
  }
}
