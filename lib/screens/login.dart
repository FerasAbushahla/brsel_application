import 'dart:convert';
import 'dart:io';

import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/screens/register.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:brsel_application/size_config.dart';
import 'package:brsel_application/wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/personalInfoModel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberMe = false;
  bool loading = false;

  String? validateEmail(String? value) {
    String pattern =
        // r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        // r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        // r"{0,253}[a-zA-Z0-9])?)*$";
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'أدخل البريد الإلكتروني';
    } else if (!regex.hasMatch(value)) {
      return 'أدخل بريد صحيح';
    } else {
      return null;
    }
  }

  Future setPreferences({
    required String currentPosition,
    required String firstName,
    required String lastName,
    required String sex,
    required String personalImage,
    required String currentPositionLatitude,
    required String currentPositionLongitude,
    required String phoneNumber,
    required int ID,
    required String token,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('currentPosition', currentPosition);
    preferences.setString('firstName', firstName);
    preferences.setString('lastName', lastName);
    preferences.setString('sex', sex);
    preferences.setString('personalImage', personalImage);
    preferences.setString('currentPositionLatitude', currentPositionLatitude);
    preferences.setString('currentPositionLongitude', currentPositionLongitude);
    preferences.setString('phoneNumber', phoneNumber);
    preferences.setInt('ID', ID);
    preferences.setString('token', token);

    print("currentPosition ${preferences.get('currentPosition')}");
    print("firstName ${preferences.get('firstName')}");
    print("lastName ${preferences.get('lastName')}");
    print("sex ${preferences.get('sex')}");
    print("personalImage ${preferences.get('personalImage')}");
    print(
        "currentPositionLatitude ${preferences.get('currentPositionLatitude')}");
    print(
        "currentPositionLongitude ${preferences.get('currentPositionLongitude')}");
    print("phoneNumber ${preferences.get('phoneNumber')}");
    print("ID ${preferences.get('ID')}");
    print("token ${preferences.get('token')}");
  }

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  File? image;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 30,
              ),
              SvgPicture.asset('assets/images/Logo.svg', height: 82),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 42, 16, 42),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'البريد الالكتروني',
                                style:
                                    MyCustomTextStyle.myTextFieldTitletextStyle,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                textDirection: TextDirection.ltr,
                                style: MyCustomTextStyle.myH1TextStyle,
                                validator: (val) => validateEmail(val),
                                controller: emailController,
                                decoration: myInputDecoration(
                                  hint: 'أدخل البريد الإلكتروني',
                                  // suffix: Icon(
                                  //   BrselApp.checkicon,
                                  //   color: myPrimaryColor,
                                  //   size: 13,
                                  // ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'كلمة المرور',
                                style:
                                    MyCustomTextStyle.myTextFieldTitletextStyle,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                maxLength: 15,
                                obscureText: true,
                                validator: (val) =>
                                    val!.isEmpty ? 'أدخل كلمة المرور' : null,
                                controller: passwordController,
                                style: MyCustomTextStyle.myH1TextStyle,
                                decoration: myInputDecoration(
                                  hint: 'أدخل كلمة المرور',
                                  // suffix: Icon(
                                  //   BrselApp.checkicon,
                                  //   color: myPrimaryColor,
                                  //   size: 13,
                                  // ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // SizedBox(
                                  //   height: 20,
                                  //   width: 20,
                                  //   child: Checkbox(
                                  //     value: rememberMe,
                                  //     onChanged: (val) {
                                  //       setState(() {
                                  //         rememberMe = val!;
                                  //         print(rememberMe);
                                  //       });
                                  //     },
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 4,
                                  // ),
                                  // Text(
                                  //   'تذكرني',
                                  //   style: MyCustomTextStyle.myH1TextStyle,
                                  // ),
                                  Spacer(),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        padding: EdgeInsets.zero),
                                    onPressed: () {},
                                    child: Text(
                                      'نسيت كلمة السر؟',
                                      style: MyCustomTextStyle
                                          .myLoginForgetPasswordTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              MyButton(
                                loading: loading,
                                color: mySecondaryColor,
                                title: 'تسجيل الدخول',
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    PersonalInfoModel response =
                                        await RemoteServices.login(
                                            email: emailController.text,
                                            password: passwordController.text);
                                    print(
                                        'view Response>>>${response.message}');
                                    if (response.message ==
                                        "User Logged In Successfully") {
                                      // final image = response.user!.avatar;
                                      // final imageTemporary = File(image.path);
                                      // setState(() {
                                      //   this.image = imageTemporary;
                                      // });
                                      http.Response imagResponse =
                                          await http.get(
                                        Uri.parse(response.user!.avatar),
                                      );
                                      final bytes = imagResponse.bodyBytes;
                                      print(bytes);
                                      String base64Image = base64Encode(
                                          bytes.buffer.asUint8List());
                                      print(base64Image);
                                      // SharedPreferences sharedPreferences =
                                      //     await SharedPreferences.getInstance();
                                      // sharedPreferences.setString('personalImage', base64Image);
                                      await setPreferences(
                                        personalImage: base64Image,
                                        ID: response.user!.id!,
                                        currentPosition:
                                            response.user!.address!,
                                        currentPositionLatitude:
                                            response.user!.latitude!,
                                        currentPositionLongitude:
                                            response.user!.longitude!,
                                        firstName: response.user!.firstName!,
                                        lastName: response.user!.lastName!,
                                        // personalImage: response.user!.avatar,
                                        phoneNumber: response.user!.phone!,
                                        sex: response.user!.gender!,
                                        token: response.token!,
                                      ).then((value) => Fluttertoast.showToast(
                                              msg: "تم تسجيل الدخول بنجاح",
                                              backgroundColor: myDarkGreyColor)
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(
                                          //   SnackBar(
                                          //     content:
                                          //         Text("تم تسجيل الدخول بنجاح"),
                                          //   ),
                                          // ),
                                          );

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  Wraper())));
                                    } else if (response.message ==
                                        "Email or Password does not match with our record.") {
                                      Fluttertoast.showToast(
                                          msg:
                                              "يوجد خطأ في البريد أو كلمة المرور",
                                          backgroundColor: myDarkGreyColor);
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   SnackBar(
                                      //     content: Text(
                                      //         "يوجد خطأ في البريد أو كلمة المرور"),
                                      //   ),
                                      // );
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "يوجد خطأ, أعد المحاولة لاحقاً",
                                          backgroundColor: myDarkGreyColor);
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   SnackBar(
                                      //     content: Text(
                                      //         "يوجد خطأ, أعد المحاولة لاحقاً"),
                                      //   ),
                                      // );
                                    }
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'ليس لديك حساب ؟',
                          style: MyCustomTextStyle.myTextFieldTitletextStyle,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.zero),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Register())));
                          },
                          child: Text(
                            'أنشئ حساب الان',
                            style: MyCustomTextStyle.myTextButtonTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
