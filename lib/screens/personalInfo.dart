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
              onPress: () {
                Navigator.pop(context);
              },
              borderRadius: 12,
              BackgroundColor: Colors.white,
              iconWidget: Padding(
                padding: EdgeInsets.all(5),
                // fit: BoxFit.scaleDown,
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
              Column(
                children: [
                  Text(
                    'المعلومات الشخصية',
                    style: MyCustomTextStyle.myTitletextStyle,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  SvgPicture.asset('assets/images/PersonalInfoProgress1.svg',
                      height: getProportionalScreenHeight(24)),
                ],
              ),
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
                                'الاسم',
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
                                  hint: 'أدخل الاسم',
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
                                'اسم العائلة',
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
                                  hint: 'أدخل اسم العائلة',
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
                                'رقم الهاتف',
                                style:
                                    MyCustomTextStyle.myTextFieldTitletextStyle,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: passwordRetypeController,
                                style: MyCustomTextStyle.myH1TextStyle,
                                keyboardType: TextInputType.phone,
                                decoration: myInputDecoration(
                                  hint: 'أدخل رقم الهاتف',
                                  prefix: SizedBox(
                                    height: 30,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          '+973',
                                          style: MyCustomTextStyle
                                              .myTextFieldTitletextStyle,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        VerticalDivider(
                                          width: 0,
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                  ),
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
                                'الجنس',
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
                                  hint: 'أدخل الجنس',
                                  suffix: Icon(
                                    BrselApp.checkicon,
                                    color: myPrimaryColor,
                                    size: 13,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              MyButton(
                                title: 'حفظ ومتابعة',
                                onPressed: () {},
                              ),
                            ],
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
