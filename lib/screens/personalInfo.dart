import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/componantes/myCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: MyCustomAppBar(
        leading: Column(
          children: [
            SizedBox(
              height: 11,
            ),
            MyIconButton(
              borderRadius: 12,
              BackgroundColor: Colors.white,
              iconWidget: FittedBox(
                fit: BoxFit.scaleDown,
                child: SvgPicture.asset(
                  'assets/images/ArrowBack Icon.svg',
                  height: 10,
                ),
              ),
            ),
          ],
        ),
      ),
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
                              SizedBox(
                                height: 40,
                              ),
                              MyButton(
                                title: 'انشاء حساب',
                                onPressed: () {},
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
