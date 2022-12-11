import 'dart:convert';

import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/componantes/myCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiriverPersonalInfo extends StatefulWidget {
  const DiriverPersonalInfo({super.key});

  @override
  State<DiriverPersonalInfo> createState() => _DiriverPersonalInfoState();
}

class _DiriverPersonalInfoState extends State<DiriverPersonalInfo> {
  String firstName = '';
  String lastName = '';
  String personalImage = '';
  bool sharedPreferencesLoading = false;
  String? token;

  bool loading = false;
  String? mySexValue;

  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final sexController = TextEditingController();

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
    print(preferences.get('sex'));
    print(preferences.get('token'));
    print(preferences.get('personalImage'));
    print(preferences.get('currentPosition'));
  }

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
                Get.back();

                // Navigator.pop(context);
              },
              borderRadius: 12,
              BackgroundColor: Colors.white,
              iconWidget: Padding(
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  'assets/images/ArrowBack Icon.svg',
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
            Text(
              'المعلومات الشخصية',
              style: MyCustomTextStyle.myTitletextStyle,
              textAlign: TextAlign.center,
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6)),
                                child: Image.memory(
                                  base64Decode(personalImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "عدد الطلبات",
                                      // '${widget.homeMeals!.deliveryTime!}د',
                                      style: MyCustomTextStyle.myH2TextStyle,
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
                                    // Obx((() {
                                    //   if (OrderHistoryController
                                    //       .isLoading.value) {
                                    //     return SizedBox();
                                    //   } else {
                                    //     return Text(
                                    //       orderHistoryController
                                    //           .orderList.length
                                    //           .toString(),
                                    //       // '5',
                                    //       style: TextStyle(
                                    //           color: myPrimaryColor,
                                    //           fontSize: 12,
                                    //           fontWeight: FontWeight.w500),
                                    //     );
                                    //   }
                                    // })),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 12,
                                  thickness: 1,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "المبلغ المصروف",
                                      // '${widget.homeMeals!.deliveryTime!}د',
                                      style: MyCustomTextStyle.myH2TextStyle,
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
                                    // Obx((() {
                                    //   if (OrderHistoryController
                                    //       .isLoading.value) {
                                    //     return SizedBox();
                                    //   } else {
                                    //     return Text(
                                    //       orderHistoryController
                                    //           .spentAmount!.value
                                    //           .toString(),
                                    //       // '125',
                                    //       style: TextStyle(
                                    //           color: myPrimaryColor,
                                    //           fontSize: 12,
                                    //           fontWeight: FontWeight.w500),
                                    //     );
                                    //   }
                                    // })),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 12,
                                  thickness: 1,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "عضو منذ",
                                      // '${widget.homeMeals!.deliveryTime!}د',
                                      style: MyCustomTextStyle.myH2TextStyle,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'الاسم',
                            style: MyCustomTextStyle.myTextFieldTitletextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'أدخل الاسم' : null,
                            controller: firstNameController,
                            style: MyCustomTextStyle.myH1TextStyle,
                            decoration: myInputDecoration(
                              hint: 'الاسم',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'اسم العائلة',
                            style: MyCustomTextStyle.myTextFieldTitletextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'أدخل اسم العائلة' : null,
                            controller: lastNameController,
                            style: MyCustomTextStyle.myH1TextStyle,
                            decoration: myInputDecoration(
                              hint: 'اسم العائلة',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'الجنس',
                            style: MyCustomTextStyle.myTextFieldTitletextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'أدخل الجنس' : null,
                            controller: sexController,
                            style: MyCustomTextStyle.myH1TextStyle,
                            decoration: myInputDecoration(
                              hint: 'الجنس',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
