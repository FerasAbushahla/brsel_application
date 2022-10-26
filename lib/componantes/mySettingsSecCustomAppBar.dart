import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MySettingsSecCustomAppBar extends StatefulWidget {
  final Widget? leading;
  final String? title;

  @override
  const MySettingsSecCustomAppBar({
    Key? key,
    this.leading,
    this.title,
  }) : super(key: key);

  @override
  State<MySettingsSecCustomAppBar> createState() =>
      _MySettingsSecCustomAppBarState();
}

class _MySettingsSecCustomAppBarState extends State<MySettingsSecCustomAppBar> {
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
                children: [
                  widget.leading!,
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.title!,
                    style: MyCustomTextStyle.myAppBarSecTitleTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 21,
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
