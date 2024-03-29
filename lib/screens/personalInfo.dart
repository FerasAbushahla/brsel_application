import 'dart:io';

import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/componantes/myCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/controllers/areasController.dart';
import 'package:brsel_application/controllers/userController.dart';
import 'package:brsel_application/models/areasModel.dart';
import 'package:brsel_application/models/personalInfoModel.dart';
import 'package:brsel_application/screens/personalImage.dart';
import 'package:brsel_application/screens/register.dart';
import 'package:brsel_application/screens/settings.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:brsel_application/size_config.dart';
import 'package:brsel_application/wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class PersonalInfo extends StatefulWidget {
  // final String? firstName;
  // final String? lastName;
  // final String? phoneNumber;
  // final String? sex;
  final bool? fromSettings;
  const PersonalInfo({Key? key, required this.fromSettings}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  AreasController areasController = Get.put(AreasController());

  bool sharedPreferencesLoading = false;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? sex;
  String? token;
  int? ID;
  String? currentPosition;
  String? personalImage;
  String? lat;
  String? long;
  String? area;
  File? image;
  String? sharedPreferenceImagePath;

  @override
  void initState() {
    areasController.onInit();
    // Future.delayed(const Duration(milliseconds: 5), () async {
    //   SharedPreferences preferences = await SharedPreferences.getInstance();
    //   print(preferences.get('firstName'));
    //   print(preferences.get('lastName'));
    //   print(preferences.get('phoneNumber'));
    //   print(preferences.get('sex'));
    //   print(preferences.get('token'));
    //   print(preferences.get('ID'));
    //   print(preferences.get('personalImage'));
    //   // firstNameController.text = widget.firstName!;
    //   // userBox = Hive.box('user');
    //   // var myUser = await userBox.getAt(0);
    //   // print(myUser);
    // });
    getSharedPrefs().then((value) {
      if (firstName != null) {
        firstNameController.text = firstName!;
      }
      if (lastName != null) {
        lastNameController.text = lastName!;
      }
      if (phoneNumber != null) {
        phoneController.text = phoneNumber!;
      }
      // if (sex != null) {
      //   mySexValue = sex!;
      // }
      if (area != null) {
        myAreaValue = area!;
      }
    });

    super.initState();
  }

  Future getSharedPrefs() async {
    setState(() {
      sharedPreferencesLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    setState(() {
      currentPosition = preferences.getString('currentPosition');
      firstName = preferences.getString('firstName');
      lastName = preferences.getString('lastName');
      sex = preferences.getString('sex');
      personalImage = preferences.getString('personalImage');
      lat = preferences.getString('currentPositionLatitude');
      long = preferences.getString('currentPositionLongitude');
      phoneNumber = preferences.getString('phoneNumber');
      ID = preferences.getInt('ID');
      token = preferences.getString('token');
      area = preferences.getString('areaID');
      sharedPreferenceImagePath =
          preferences.getString('personalImageFileLocation');

      if (sharedPreferenceImagePath != null) {
        setState(() {
          image = File(sharedPreferenceImagePath!);
        });
      } else {
        setState(() {
          image = null;
        });
      }

      // firstName = preferences.getString("firstName");
      // lastName = preferences.getString("lastName");
      // phoneNumber = preferences.getString("phoneNumber");
      // sex = preferences.getString("sex");
      // token = preferences.getString("token");
      // ID = preferences.getInt("ID");
      // currentPosition = preferences.getString("currentPosition");
      // personalImage = preferences.getString("personalImage") ?? '';
      // sharedPreferencesLoading = false;
    });

    print(preferences.get('firstName'));
    print(preferences.get('lastName'));
    print(preferences.get('phoneNumber'));
    print(preferences.get('sex'));
    print(preferences.get('token'));
    print(preferences.get('ID'));
    print(preferences.get('personalImage'));
    print(preferences.get('currentPosition'));
    print(preferences.get('currentPositionLatitude'));
    print(preferences.get('currentPositionLongitude'));
    print(preferences.get('areaID'));
    print(preferences.get('personalImageFileLocation'));
  }

  String? validatePhoneNum(String? value) {
    String pattern = r'^[0-9]*$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'أدخل رقم الهاتف';
    } else if (!regex.hasMatch(value)) {
      return 'أدخل رقم هاتف صحيح';
    } else {
      return null;
    }
  }

  UserController userController = Get.put(UserController());

  late Box userBox;

  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final sexController = TextEditingController();
  bool loading = false;
  String? mySexValue;
  String? myAreaValue;
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
                if (widget.fromSettings == true) {
                  Get.back();
                } else {
                  Get.off(Register());
                }
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
                        Obx((() {
                          if (AreasController.isLoading.value) {
                            return SizedBox(
                                // width: 25,
                                height: 150,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          } else if (areasController.areasList.isNotEmpty) {
                            return Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'الاسم',
                                    style: MyCustomTextStyle
                                        .myTextFieldTitletextStyle,
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
                                      hint: 'أدخل الاسم',
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
                                    'اسم العائلة',
                                    style: MyCustomTextStyle
                                        .myTextFieldTitletextStyle,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    validator: (val) => val!.isEmpty
                                        ? 'أدخل اسم العائلة'
                                        : null,
                                    controller: lastNameController,
                                    style: MyCustomTextStyle.myH1TextStyle,
                                    decoration: myInputDecoration(
                                      hint: 'أدخل اسم العائلة',
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
                                    'رقم الهاتف',
                                    style: MyCustomTextStyle
                                        .myTextFieldTitletextStyle,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    maxLength: 8,
                                    validator: (val) => validatePhoneNum(val),
                                    // validator: (val) =>
                                    //     val!.isEmpty ? 'أدخل رقم الهاتف' : null,
                                    controller: phoneController,
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
                                              '+968',
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
                                      // suffix: Icon(
                                      //   BrselApp.checkicon,
                                      //   color: myPrimaryColor,
                                      //   size: 13,
                                      // ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Text(
                                  //   'الجنس',
                                  //   style: MyCustomTextStyle
                                  //       .myTextFieldTitletextStyle,
                                  // ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  // DropdownButtonFormField(
                                  //   validator: (value) {
                                  //     if (value == null) {
                                  //       return 'أدخل الجنس';
                                  //     } else {
                                  //       return null;
                                  //     }
                                  //   },
                                  //   decoration: const InputDecoration(
                                  //     fillColor: myBackgroundFillingColor,
                                  //     filled: true,
                                  //     hintText: '',
                                  //     border: OutlineInputBorder(
                                  //       borderRadius: const BorderRadius.all(
                                  //         const Radius.circular(8.0),
                                  //       ),
                                  //       borderSide: BorderSide(
                                  //         width: 1.0,
                                  //         color: myBackgroundFillingColor,
                                  //       ),
                                  //     ),
                                  //     enabledBorder: OutlineInputBorder(
                                  //       borderRadius: const BorderRadius.all(
                                  //         const Radius.circular(8.0),
                                  //       ),
                                  //       borderSide: BorderSide(
                                  //         width: 1.0,
                                  //         color: myBackgroundFillingColor,
                                  //       ),
                                  //     ),
                                  //     contentPadding: EdgeInsets.symmetric(
                                  //         horizontal: 11, vertical: 0),
                                  //   ),
                                  //   isExpanded: true,
                                  //   value: mySexValue,
                                  //   hint: Text(
                                  //     'اختر الجنس',
                                  //     style: MyCustomTextStyle.myHintTextStyle,
                                  //   ),
                                  //   onChanged: (value) => setState(
                                  //       () => mySexValue = value.toString()),
                                  //   items: [
                                  //     DropdownMenuItem(
                                  //         child: Container(
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 right: 11),
                                  //             child: Container(
                                  //               alignment:
                                  //                   Alignment.centerRight,
                                  //               child: Text('ذكر',
                                  //                   style: MyCustomTextStyle
                                  //                       .myH1TextStyle),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         value: 'ذكر'),
                                  //     DropdownMenuItem(
                                  //         child: Container(
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 right: 11),
                                  //             child: Container(
                                  //               alignment:
                                  //                   Alignment.centerRight,
                                  //               child: Text('أنثى',
                                  //                   style: MyCustomTextStyle
                                  //                       .myH1TextStyle),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         value: 'أنثى'),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'المنطقة',
                                    style: MyCustomTextStyle
                                        .myTextFieldTitletextStyle,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  DropdownButtonFormField(
                                      validator: (value) {
                                        if (value == null) {
                                          return 'اختر المنطقة';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        fillColor: myBackgroundFillingColor,
                                        filled: true,
                                        hintText: '',
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(8.0),
                                          ),
                                          borderSide: BorderSide(
                                            width: 1.0,
                                            color: myBackgroundFillingColor,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(8.0),
                                          ),
                                          borderSide: BorderSide(
                                            width: 1.0,
                                            color: myBackgroundFillingColor,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 11, vertical: 0),
                                      ),
                                      isExpanded: true,
                                      value: myAreaValue,
                                      hint: Text(
                                        'اختر المنطقة',
                                        style:
                                            MyCustomTextStyle.myHintTextStyle,
                                      ),
                                      onChanged: (value) => setState(
                                          () => myAreaValue = value.toString()),
                                      items: List.generate(
                                        areasController.areasList.length,
                                        (index) => myDropDownMenuItem(
                                            areasDatum: areasController
                                                .areasList[index]),
                                      )),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  MyButton(
                                    loading: loading,
                                    color: mySecondaryColor,
                                    title: 'حفظ ومتابعة',
                                    onPressed: () async {
                                      if (widget.fromSettings == true) {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          print('loading $loading');
                                          SharedPreferences sharedPreferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          sharedPreferences.setString(
                                              'firstName',
                                              firstNameController.text);
                                          print('firstName');
                                          print(firstNameController.text);
                                          sharedPreferences.setString(
                                              'lastName',
                                              lastNameController.text);
                                          print('lastName');
                                          print(lastNameController.text);
                                          sharedPreferences.setString(
                                              'phoneNumber',
                                              phoneController.text);
                                          print('phoneNumber');
                                          print(phoneController.text);
                                          // sharedPreferences.setString(
                                          //     'sex', mySexValue.toString());
                                          // print('sex');
                                          // print(mySexValue);
                                          sharedPreferences.setString(
                                              'areaID', myAreaValue!);
                                          print('areaID');
                                          print(myAreaValue);
                                          getSharedPrefs().then(
                                            (value) async {
                                              PersonalInfoModel
                                                  personalInfoResponse =
                                                  await RemoteServices
                                                      .userInfoRegister(
                                                access_token: token,
                                                address: currentPosition,
                                                firstName: firstName,
                                                lastName: lastName,
                                                // gender: sex,
                                                image: image,
                                                lat: lat,
                                                long: long,
                                                phoneNumber: phoneNumber,
                                                userID: ID.toString(),
                                                place_id: area,
                                              );
                                              if (personalInfoResponse
                                                      .message ==
                                                  "User updated Successfully") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "تم تعديل بياناتك الشخصية",
                                                    backgroundColor:
                                                        myDarkGreyColor);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: ((context) =>
                                                        Wraper()),
                                                  ),
                                                );
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "يوجد مشكلة, أعد المحاولة لاحقاً",
                                                    backgroundColor:
                                                        myDarkGreyColor);
                                              }
                                            },
                                          );
                                          setState(() {
                                            loading = false;
                                          });
                                          print('loading $loading');
                                        }
                                      } else {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          SharedPreferences sharedPreferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          sharedPreferences.setString(
                                              'firstName',
                                              firstNameController.text);
                                          print('firstName');
                                          print(firstNameController.text);
                                          sharedPreferences.setString(
                                              'lastName',
                                              lastNameController.text);
                                          print('lastName');
                                          print(lastNameController.text);
                                          sharedPreferences.setString(
                                              'phoneNumber',
                                              phoneController.text);
                                          print('phoneNumber');
                                          print(phoneController.text);
                                          sharedPreferences.setString(
                                              'sex', mySexValue.toString());
                                          print('sex');
                                          sharedPreferences.setString(
                                              'areaID', myAreaValue!);
                                          print('areaID');
                                          print(myAreaValue);
                                          setState(() {
                                            loading = false;
                                          });
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: ((context) =>
                                                  PersonalImage(
                                                    fromSettings: false,
                                                  )),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                          // else if (areasController.areasList.isEmpty) {
                          //   return Container(
                          //     height: 100,
                          //     child: Center(
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Icon(
                          //             Icons.error_outline,
                          //             size: 40,
                          //             color: myGreyColor,
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           Text(
                          //             'لا يوجد طلبات في سابقة',
                          //             style: MyCustomTextStyle.myHintTextStyle,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   );
                          // }
                          else {
                            return Center(
                              child: Icon(
                                Icons.error_outline,
                              ),
                            );
                          }
                        })),
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

  DropdownMenuItem<String> myDropDownMenuItem({AreasDatum? areasDatum}) {
    return DropdownMenuItem(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(right: 11),
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                areasDatum!.value!,
                style: MyCustomTextStyle.myH1TextStyle,
              ),
            ),
          ),
        ),
        value: areasDatum.id.toString());
  }
}
