import 'package:brsel_application/componantes/checkBoxFormField.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/models/registerModel.dart';
import 'package:brsel_application/screens/personalInfo.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                                validator: (val) => val!.isEmpty
                                    ? 'أدخل البريد الإلكتروني'
                                    : null,
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
                                title: 'انشاء حساب',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    RegisterModel registerResponse =
                                        await RemoteServices.register(
                                            email: emailController.text,
                                            password: passwordController.text);
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString(
                                        'token', registerResponse.token!);
                                    print('token');
                                    print(registerResponse.token!);
                                    if (registerResponse.message ==
                                        'User Created Successfully') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              PersonalInfo()),
                                        ),
                                      );
                                    }
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
                          onPressed: () {},
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
