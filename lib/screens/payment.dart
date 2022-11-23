import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/myOrdersCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/screens/orderSuccess.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool switchValue = false;
  bool loading = false;
  bool isButtonDisabled = true;

  String? userAddress;

  final cardOwnerName = TextEditingController();
  final cardNum = TextEditingController();
  final cardExpDate = TextEditingController();
  final cardSecNum = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (switchValue = false) {
      setState(() {
        isButtonDisabled = false;
      });
    } else {
      setState(() {
        isButtonDisabled = true;
      });
    }
    getSharedPrefs();
  }

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    setState(() {
      userAddress = preferences.getString("currentPosition");

      print(userAddress);
    });

    print(preferences.get('currentPosition'));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyOrdersCustomAppBar(
              title: 'طلباتي',
              leading: MyIconButton(
                onPress: () {
                  Navigator.pop(context);
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
            ),
            Expanded(
              child: SingleChildScrollView(
                // physics: NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        // height: 65,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: myPrimaryColor.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                        child: Icon(
                                          size: 26,
                                          Icons.location_on_outlined,
                                          color: myPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'الموقع',
                                        style: MyCustomTextStyle
                                            .myCardTitletextStyle,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        userAddress!,
                                        style:
                                            MyCustomTextStyle.myCardtextStyle,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.center,
                                    child: RawMaterialButton(
                                      constraints: BoxConstraints(),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      onPressed: () {},
                                      fillColor: myPrimaryColor,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 14.0,
                                      ),
                                      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.home_outlined,
                                        color: myPrimaryColor,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SvgPicture.asset(
                                          'assets/images/dashedLine.svg'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 2),
                                        child: Icon(
                                          BrselApp.locationsecicon,
                                          color: myPrimaryColor,
                                          size: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'بارسل',
                                          style: MyCustomTextStyle
                                              .myCardTitletextStyle,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'طلبات |  وقت التوصيل المتوقع 30 دقيقة',
                                          style:
                                              MyCustomTextStyle.myHintTextStyle,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'عنوان المنزل',
                                          style: MyCustomTextStyle
                                              .myCardTitletextStyle,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          userAddress!,
                                          style:
                                              MyCustomTextStyle.myHintTextStyle,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'إضافة وسيلة دفع',
                                style: MyCustomTextStyle
                                    .myTextButtonLightTextStyle,
                              ),
                              RawMaterialButton(
                                elevation: 0,
                                constraints: BoxConstraints(),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6)),
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              35, 15, 35, 10),
                                          child: Form(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'اسم صاحب  البطاقة',
                                                style: MyCustomTextStyle
                                                    .myTextFieldTitletextStyle,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                // maxLength: 40,
                                                textDirection:
                                                    TextDirection.ltr,
                                                // validator: (val) =>
                                                //     validateEmail(val),
                                                controller: cardOwnerName,
                                                style: MyCustomTextStyle
                                                    .myH1TextStyle,
                                                decoration: myInputDecoration(
                                                    // hint:
                                                    //     'أدخل البريد الإلكتروني',
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
                                              Text(
                                                'رقم البطاقة',
                                                style: MyCustomTextStyle
                                                    .myTextFieldTitletextStyle,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                // maxLength: 15,
                                                // obscureText: true,
                                                // validator: (val) => val!.isEmpty
                                                //     ? 'أدخل كلمة المرور'
                                                //     : null,
                                                controller: cardNum,
                                                style: MyCustomTextStyle
                                                    .myH1TextStyle,
                                                decoration: myInputDecoration(
                                                    // hint: 'أدخل كلمة المرور',
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
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'تاريخ الانتهاء',
                                                          style: MyCustomTextStyle
                                                              .myTextFieldTitletextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        // Expanded(
                                                        // child:
                                                        TextFormField(
                                                          // maxLength: 15,
                                                          // obscureText: true,
                                                          // validator: (val) => val!.isEmpty
                                                          //     ? 'أدخل كلمة المرور'
                                                          //     : null,
                                                          controller:
                                                              cardExpDate,
                                                          style:
                                                              MyCustomTextStyle
                                                                  .myH1TextStyle,
                                                          decoration: myInputDecoration(
                                                              // hint: 'أدخل كلمة المرور',
                                                              // suffix: Icon(
                                                              //   BrselApp.checkicon,
                                                              //   color: myPrimaryColor,
                                                              //   size: 13,
                                                              // ),
                                                              ),
                                                        ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'الرقم السري',
                                                          style: MyCustomTextStyle
                                                              .myTextFieldTitletextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        // Expanded(
                                                        // child:
                                                        TextFormField(
                                                          // maxLength: 15,
                                                          // obscureText: true,
                                                          // validator: (val) => val!.isEmpty
                                                          //     ? 'أدخل كلمة المرور'
                                                          //     : null,
                                                          controller:
                                                              cardSecNum,
                                                          style:
                                                              MyCustomTextStyle
                                                                  .myH1TextStyle,
                                                          decoration: myInputDecoration(
                                                              // hint: 'أدخل كلمة المرور',
                                                              // suffix: Icon(
                                                              //   BrselApp.checkicon,
                                                              //   color: myPrimaryColor,
                                                              //   size: 13,
                                                              // ),
                                                              ),
                                                        ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              MyButton(
                                                title: 'حفظ ومتابعة',
                                                color: myPrimaryColor,
                                                loading: loading,
                                                onPressed: () {},
                                              )
                                            ],
                                          )),
                                        );
                                      });
                                },
                                fillColor: Colors.white,
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: myGreyColor,
                                ),
                                padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                                shape: CircleBorder(),
                              ),
                              // Material(
                              //   child: Container(
                              //     decoration:
                              //         BoxDecoration(shape: BoxShape.circle),
                              //     child: IconButton(
                              //       // splashRadius: 60,
                              //       // splashColor: myPrimaryColor,
                              //       constraints: BoxConstraints(),
                              //       padding: EdgeInsets.zero,
                              //       onPressed: () {},
                              //       icon: Icon(
                              //         Icons.edit,
                              //         size: 20,
                              //         color: myGreyColor,
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 25, 10),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    BrselApp.paymenticon,
                                    color: myGreyColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'الدفع عند الاستلام',
                                    style: MyCustomTextStyle
                                        .myTextButtonLightTextStyle,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Switch(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                inactiveThumbColor: myGreyColor,
                                inactiveTrackColor:
                                    myGreyColor.withOpacity(0.2),
                                value: switchValue,
                                onChanged: (val) {
                                  setState(() {
                                    switchValue = val;
                                    isButtonDisabled = !val;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      TextField(
                        maxLines: 8,
                        style: MyCustomTextStyle.myH1TextStyle,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: MyCustomTextStyle.myHintTextStyle,
                          hintText: 'أكتب أي ملاحظة',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 11, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: myBackgroundFillingColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: myGreyColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: SizeConfig.screenWidth,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 18, 0, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'إجمالي',
                                  style:
                                      MyCustomTextStyle.mySearchHintTextStyle,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '210.80',
                                      style: MyCustomTextStyle
                                          .mySearchHintTextStyle,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'ر.ع',
                                      style: MyCustomTextStyle
                                          .mySearchHintTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: isButtonDisabled
                                  ? null
                                  : () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          contentPadding:
                                              EdgeInsets.only(top: 15),
                                          title: Icon(
                                            BrselApp.paymenticon,
                                            color: myPrimaryColor,
                                          ),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'تأكيد الطلب ؟',
                                                  style: TextStyle(
                                                      color: mySecGreyColor,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Divider(
                                                height: 0,
                                              ),
                                              IntrinsicHeight(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          'الغاء',
                                                          style: TextStyle(
                                                              color:
                                                                  myGreyColor,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                    VerticalDivider(
                                                      width: 0,
                                                      // thickness: 1,
                                                    ),
                                                    Expanded(
                                                      child: TextButton(
                                                        onPressed: () async {
                                                          // Navigator.pop(
                                                          //     context);
                                                          Navigator.pushReplacement(
                                                              Get.context!,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          OrderSuccess()));
                                                          // Get.back();
                                                          // Navigator.pushAndRemoveUntil(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder:
                                                          //             (context) =>
                                                          //                 OrderSuccess()),
                                                          //     (r) => false);
                                                        },
                                                        child: Text(
                                                          'تأكيد',
                                                          style: TextStyle(
                                                              color:
                                                                  myPrimaryColor,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                elevation: 0,
                                backgroundColor: myPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(6, 0, 16, 0),
                                child: Row(
                                  children: [
                                    Text(
                                      'الدفع',
                                      style:
                                          MyCustomTextStyle.myButtonTextStyle,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 2, 3, 2),
                                        child: Icon(
                                          textDirection: TextDirection.ltr,
                                          Icons.arrow_back_ios,
                                          color: myPrimaryColor,
                                          size: 20.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
