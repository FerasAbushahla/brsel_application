import 'package:brsel_application/componantes/myCartBadgedButton.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants.dart';

class MyOrderDetailsCustomAppBar extends StatefulWidget {
  final String? title;

  @override
  const MyOrderDetailsCustomAppBar({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<MyOrderDetailsCustomAppBar> createState() =>
      _MyOrderDetailsCustomAppBarState();
}

class _MyOrderDetailsCustomAppBarState
    extends State<MyOrderDetailsCustomAppBar> {
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
                  MyIconButton(
                    onPress: () {
                      Get.back();
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
                  // widget.leading!,
                  Text(
                    widget.title!,
                    style: MyCustomTextStyle.myAppBarTitleTextStyle,
                  ),
                  Container(
                    width: 42,
                  ),
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
