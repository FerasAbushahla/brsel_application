import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class MyDetailsCustomAppBar extends StatelessWidget {
  final VoidCallback? leadingOnPressed;
  final VoidCallback? action1OnPressed;
  final VoidCallback? action2OnPressed;
  final Widget? leading;
  final String? title;
  @override
  const MyDetailsCustomAppBar({
    Key? key,
    this.leadingOnPressed,
    this.action1OnPressed,
    this.action2OnPressed,
    this.leading,
    this.title,
  }) : super(key: key);

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
                  leading!,
                  Text(
                    title!,
                    style: MyCustomTextStyle.myAppBarTitleTextStyle,
                  ),
                  MyIconButton(
                      BackgroundColor: myBackgroundFillingColor,
                      borderRadius: 6,
                      iconWidget:
                          SvgPicture.asset('assets/images/CartIcon.svg'),
                      onPress: action1OnPressed),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
