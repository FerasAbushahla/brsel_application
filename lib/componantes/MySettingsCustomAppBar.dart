import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class MySettingsCustomAppBar extends StatefulWidget {
  // final VoidCallback? leadingOnPressed;
  final VoidCallback? action1OnPressed;
  final VoidCallback? action2OnPressed;
  // final Widget? leading;
  final Widget? cartButtonWidget;
  final String? title;

  @override
  const MySettingsCustomAppBar({
    Key? key,
    // this.leadingOnPressed,
    this.action1OnPressed,
    this.action2OnPressed,
    // this.leading,
    this.title,
    this.cartButtonWidget,
  }) : super(key: key);

  @override
  State<MySettingsCustomAppBar> createState() => _MySettingsCustomAppBarState();
}

class _MySettingsCustomAppBarState extends State<MySettingsCustomAppBar> {
  String? userAddress = '';

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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
      decoration: BoxDecoration(color: myBackgroundColor),
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
                  Container(
                    width: 42,
                  ),
                  // widget.leading!,
                  Text(
                    widget.title!,
                    style: MyCustomTextStyle.myAppBarTitleTextStyle,
                  ),
                  widget.cartButtonWidget!,
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
