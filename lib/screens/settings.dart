import 'dart:convert';

import 'package:brsel_application/componantes/MySettingsCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String firstName = '';
  String lastName = '';
  String personalImage = '';
  bool sharedPreferencesLoading = false;

  Future getSharedPrefs() async {
    setState(() {
      sharedPreferencesLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    setState(() {
      firstName = preferences.getString("firstName") ?? '';
      print(firstName);
      lastName = preferences.getString("lastName") ?? '';
      print(lastName);
      personalImage = preferences.getString("personalImage") ?? '';
      print(personalImage);
      sharedPreferencesLoading = false;
    });

    print(preferences.get('firstName'));
    print(preferences.get('lastName'));
    print(preferences.get('phoneNumber'));
    print(preferences.get('sex'));
    print(preferences.get('token'));
    print(preferences.get('personalImage'));
    print(preferences.get('currentPosition'));
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            MySettingsCustomAppBar(
              title: 'الإعدادات',
              // leading: MyIconButton(
              //     BackgroundColor: Colors.white,
              //     borderRadius: 6,
              //     iconWidget: SvgPicture.asset('assets/images/MenuIcon.svg'),
              //     onPress: () {
              //       ZoomDrawer.of(context)!.toggle();
              //     }),
              cartButtonWidget: MyIconButton(
                  BackgroundColor: Colors.white,
                  borderRadius: 6,
                  iconWidget: SvgPicture.asset('assets/images/CartIcon.svg'),
                  onPress: () {}),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1.5,
                            blurRadius: 1.5,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                      width: SizeConfig.screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (sharedPreferencesLoading) ...[
                              Center(
                                  child: SizedBox(
                                      width: 55,
                                      height: 55,
                                      child: CircularProgressIndicator()))
                            ] else if (!sharedPreferencesLoading) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Image.memory(
                                    base64Decode(personalImage),
                                    fit: BoxFit.cover,
                                  ),
                                  // child: Image.asset(
                                  //   'assets/images/Profile.jpg',
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              ),
                            ],
                            Expanded(
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "عدد الطلبات",
                                          // '${widget.homeMeals!.deliveryTime!}د',
                                          style:
                                              MyCustomTextStyle.myH2TextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '5',
                                          style: TextStyle(
                                              color: myPrimaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    VerticalDivider(
                                      width: 0,
                                      thickness: 1,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "المبلغ المصروف",
                                          // '${widget.homeMeals!.deliveryTime!}د',
                                          style:
                                              MyCustomTextStyle.myH2TextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '125',
                                          style: TextStyle(
                                              color: myPrimaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    VerticalDivider(
                                      width: 0,
                                      thickness: 1,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "عضو منذ",
                                          // '${widget.homeMeals!.deliveryTime!}د',
                                          style:
                                              MyCustomTextStyle.myH2TextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '2022',
                                          style: TextStyle(
                                              color: myPrimaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        settingsListItem(
                            icon: Icon(BrselApp.profile),
                            title: 'المعلومات الشخصية',
                            onTap: () {})
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  InkWell settingsListItem({String? title, VoidCallback? onTap, Widget? icon}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
          child: Row(
            children: [
              icon!,
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: MyCustomTextStyle.myH2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'معولمات الاتصال والشخصية',
                    style: MyCustomTextStyle.myH1TextStyle,
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_ios,
                  textDirection: TextDirection.ltr,
                  size: 17,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
