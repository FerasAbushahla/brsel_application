import 'package:brsel_application/componantes/checkBoxFormField.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/userController.dart';
import 'package:brsel_application/models/registerModel.dart';
import 'package:brsel_application/screens/login.dart';
import 'package:brsel_application/screens/personalInfo.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../componantes/myButton.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 5), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      print(preferences.get('token'));
    });
    super.initState();
  }

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

  UserController userController = Get.put(UserController());

  late Box userBox;

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRetypeController = TextEditingController();
  bool agree = false;
  bool loading = false;
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
                                // textDirection: TextDirection.ltr,
                                validator: (val) => validateEmail(val),
                                controller: emailController,
                                style: MyCustomTextStyle.myH1TextStyle,
                                decoration: myInputDecoration(
                                  hint: 'أدخل البريد الإلكتروني',
                                  suffix: Icon(
                                    BrselApp.checkicon,
                                    color: myPrimaryColor,
                                    size: 13,
                                  ),
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
                                obscureText: true,
                                validator: (val) =>
                                    val!.isEmpty ? 'أدخل كلمة المرور' : null,
                                controller: passwordController,
                                style: MyCustomTextStyle.myH1TextStyle,
                                decoration: myInputDecoration(
                                  hint: 'أدخل كلمة المرور',
                                  suffix: Icon(
                                    BrselApp.checkicon,
                                    color: myPrimaryColor,
                                    size: 13,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'تكرار كلمة المرور',
                                style:
                                    MyCustomTextStyle.myTextFieldTitletextStyle,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                obscureText: true,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'أدخل كلمة المرور';
                                  }
                                  if (val != passwordController.text) {
                                    return 'كلمة المرور غير مطابقة';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: passwordRetypeController,
                                style: MyCustomTextStyle.myH1TextStyle,
                                decoration: myInputDecoration(
                                  hint: 'أدخل كلمة المرور',
                                  suffix: Icon(
                                    BrselApp.checkicon,
                                    color: myPrimaryColor,
                                    size: 13,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CheckboxFormField(
                                validator: (val) => val == false
                                    ? 'يجب الموافقة على الأحكام والشروط'
                                    : null,
                                initialValue: agree,
                                onSaved: (val) {
                                  setState(() {
                                    agree = val!;
                                  });
                                },
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'من خلال إنشاء حساب ، فإنك توافق على',
                                      style: MyCustomTextStyle.myH1TextStyle,
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          padding: EdgeInsets.zero),
                                      onPressed: () {
                                        print('الأحكام والشروط');
                                      },
                                      child: Text(
                                        'الأحكام والشروط',
                                        style: MyCustomTextStyle
                                            .myTextButtonTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     SizedBox(
                              //       height: 20,
                              //       width: 20,
                              //       child: Checkbox(
                              //         value: agree,
                              //         onChanged: (val) {
                              //           setState(() {
                              //             agree = val!;
                              //             print(agree);
                              //           });
                              //         },
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 4,
                              //     ),
                              //     Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           'من خلال إنشاء حساب ، فإنك توافق على',
                              //           style: MyCustomTextStyle.myH1TextStyle,
                              //         ),
                              //         TextButton(
                              //           style: TextButton.styleFrom(
                              //               tapTargetSize: MaterialTapTargetSize
                              //                   .shrinkWrap,
                              //               padding: EdgeInsets.zero),
                              //           onPressed: () {},
                              //           child: Text(
                              //             'الأحكام والشروط ',
                              //             style: MyCustomTextStyle
                              //                 .myTextButtonTextStyle,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                              SizedBox(
                                height: 40,
                              ),
                              MyButton(
                                loading: loading,
                                color: mySecondaryColor,
                                title: 'انشاء حساب',
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    RegisterModel registerResponse =
                                        await RemoteServices.register(
                                            email: emailController.text,
                                            password: passwordController.text);

                                    if (registerResponse.message ==
                                        'User Created Successfully') {
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      sharedPreferences.setString(
                                          'token', registerResponse.token!);
                                      print('token');
                                      sharedPreferences.setString(
                                          'email', emailController.text);
                                      print('email');

                                      userBox = Hive.box('user');
                                      await userBox
                                          .add(userController.user)
                                          .then((value) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: ((context) =>
                                                      PersonalInfo()),
                                                ),
                                              ));
                                    } else if (registerResponse
                                            .errors!.email?[0] ==
                                        'قيمة الحقل البريد الالكتروني مُستخدمة من قبل') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "البريد الالكتروني مستخدم من قبل, بإمكانك تسجيل الدخول"),
                                        ),
                                      );
                                    } else {
                                      // Get.snackbar(
                                      //   'خطأ',
                                      //   'خطأ في إنشاء الحساب, أعد المحاولة',
                                      // );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "خطأ في إنشاء الحساب, أعد المحاولة"),
                                        ),
                                      );
                                    }
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'لديك حساب مسجل ؟',
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
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            'سجل الدخول',
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
