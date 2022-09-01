import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/screens/register.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberMe = false;
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
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Checkbox(
                                      value: rememberMe,
                                      onChanged: (val) {
                                        setState(() {
                                          rememberMe = val!;
                                          print(rememberMe);
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'تذكرني',
                                    style: MyCustomTextStyle.myH1TextStyle,
                                  ),
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
                                title: 'تسجيل الدخول',
                                onPressed: () {},
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
