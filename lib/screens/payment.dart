import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/myOrdersCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        // height: 65,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'الموقع',
                                    style:
                                        MyCustomTextStyle.myCardTitletextStyle,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'data',
                                    style: MyCustomTextStyle.myCardtextStyle,
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
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 8),
                              //   child: ClipOval(
                              //     child: Material(
                              //       color: myPrimaryColor,
                              //       child: InkWell(
                              //         // splashColor: Colors.red, // Splash color
                              //         onTap: () async {},
                              //         child: SizedBox(
                              //           width: 28,
                              //           height: 28,
                              //           child: Icon(
                              //             Icons.edit,
                              //             color: Colors.white,
                              //             size: 20,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
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
                              onPressed: () {},
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
