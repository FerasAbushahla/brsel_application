import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/screens/meals.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class MyHomeCustomAppBar extends StatefulWidget {
  final VoidCallback? action1OnPressed;
  final VoidCallback? action2OnPressed;
  final Widget? leading;

  @override
  const MyHomeCustomAppBar({
    Key? key,
    this.action1OnPressed,
    this.action2OnPressed,
    this.leading,
  }) : super(key: key);

  @override
  State<MyHomeCustomAppBar> createState() => _MyHomeCustomAppBarState();
}

class _MyHomeCustomAppBarState extends State<MyHomeCustomAppBar> {
  String? userAddress = '';

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    setState(() {
      userAddress = preferences.getString("currentPosition");
      print(userAddress);
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
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 11, 20, 0),
        child: Container(
          // height: getProportionalScreenHeight(124),
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.leading!,
                  Container(
                    height: getProportionalScreenHeight(42),
                    width: getProportionalScreenWidth(140),
                    decoration: BoxDecoration(
                      color: myBackgroundFillingColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: myBorderGreyColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: myPrimaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'منزل',
                                style: MyCustomTextStyle.myH1TextStyle,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 14,
                                color: myPrimaryColor,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userAddress!,
                                style:
                                    MyCustomTextStyle.myH1withOpacityTextStyle,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  MyIconButton(
                      BackgroundColor: myBackgroundFillingColor,
                      borderRadius: 6,
                      iconWidget:
                          SvgPicture.asset('assets/images/CartIcon.svg'),
                      onPress: widget.action1OnPressed),
                ],
              ),
              SizedBox(
                height: 21,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      child: TextField(
                        // enabled: false,
                        readOnly: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Meals(
                                        focus: true,
                                      )));
                        },
                        // enabled: false,
                        style: MyCustomTextStyle.myH1TextStyle,
                        decoration: searchInputDecoration(
                          hint: 'ابحث عن أي مطعم,وجبة أو مطبخ',
                          prefix: Icon(
                            BrselApp.searchicon,
                            size: 17,
                            color: myPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  MyIconButton(
                      BackgroundColor: myBackgroundFillingColor,
                      borderRadius: 6,
                      iconWidget:
                          SvgPicture.asset('assets/images/FilterIcon.svg'),
                      onPress: widget.action2OnPressed),
                ],
              ),
              SizedBox(
                height: 9,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
