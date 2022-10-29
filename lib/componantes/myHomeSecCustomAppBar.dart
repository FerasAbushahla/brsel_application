import 'package:brsel_application/componantes/myCartBadgedButton.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class MyHomeSecCustomAppBar extends StatefulWidget {
  // final String title;
  // final Widget? leading;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? action1OnPressed;
  final VoidCallback? action2OnPressed;
  final Widget? leading;
  final Widget? searchBar;
  final String? title;
  final bool focus;

  // const MyHomeCustomAppBar(
  //     {Key? key, this.onPressed, required this.title, this.leading})
  //     : super(key: key);
  @override
  const MyHomeSecCustomAppBar({
    Key? key,
    this.leadingOnPressed,
    this.action1OnPressed,
    this.action2OnPressed,
    this.leading,
    this.searchBar,
    this.title,
    required this.focus,
  }) : super(key: key);

  @override
  State<MyHomeSecCustomAppBar> createState() => _MyHomeSecCustomAppBarState();
}

class _MyHomeSecCustomAppBarState extends State<MyHomeSecCustomAppBar> {
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
                  Text(
                    widget.title!,
                    style: MyCustomTextStyle.myAppBarTitleTextStyle,
                  ),
                  MyCartBadgedButton(),
                  // MyIconButton(
                  //     BackgroundColor: myBackgroundFillingColor,
                  //     borderRadius: 6,
                  //     iconWidget:
                  //         SvgPicture.asset('assets/images/CartIcon.svg'),
                  //     onPress: widget.action1OnPressed),
                ],
              ),
              SizedBox(
                height: 21,
              ),
              widget.searchBar!,
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
