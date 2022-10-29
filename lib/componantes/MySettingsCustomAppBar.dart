import 'package:brsel_application/componantes/myCartBadgedButton.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class MySettingsCustomAppBar extends StatefulWidget {
  // final VoidCallback? leadingOnPressed;
  final VoidCallback? action1OnPressed;
  final VoidCallback? action2OnPressed;
  // final Widget? leading;
  final String? title;

  @override
  const MySettingsCustomAppBar({
    Key? key,
    // this.leadingOnPressed,
    this.action1OnPressed,
    this.action2OnPressed,
    // this.leading,
    this.title,
  }) : super(key: key);

  @override
  State<MySettingsCustomAppBar> createState() => _MySettingsCustomAppBarState();
}

class _MySettingsCustomAppBarState extends State<MySettingsCustomAppBar> {
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
                  MyCartBadgedButton(),
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
