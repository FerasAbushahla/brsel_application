import 'dart:convert';

import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class MyDriverHomeCustomAppBar extends StatefulWidget {
  @override
  const MyDriverHomeCustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDriverHomeCustomAppBar> createState() =>
      _MyDriverHomeCustomAppBarState();
}

class _MyDriverHomeCustomAppBarState extends State<MyDriverHomeCustomAppBar> {
  String firstName = '';
  String lastName = '';
  String personalImage = '';
  bool sharedPreferencesLoading = false;
  Future getSharedPrefs() async {
    setState(() {
      sharedPreferencesLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    personalImage = preferences.getString("personalImage") ?? '';
    print(personalImage);
    setState(() {
      sharedPreferencesLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 11, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // borderRadius: BorderRadius.circular(6),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: MemoryImage(
                          base64Decode(personalImage),
                        ),
                      )),
                ),
                SizedBox(
                  width: 13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' !مرحبا بك',
                      style: MyCustomTextStyle.myDriverAppBarTitleTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'ابق آمن على الطريق',
                      style: MyCustomTextStyle.myDriverAppBarSecTextStyle,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: mySecondaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Row(
                  children: [
                    Text(
                      'استقبال الطلبات',
                      style: MyCustomTextStyle.myDriverTitletextStyle,
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        elevation: 0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 7, 6, 7),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/driverStat Icon.svg',
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              'غير متاح',
                              style: MyCustomTextStyle.myDriverStatTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
