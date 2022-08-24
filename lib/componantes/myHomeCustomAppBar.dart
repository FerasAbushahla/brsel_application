import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class MyHomeCustomAppBar extends StatelessWidget {
  // final String title;
  // final Widget? leading;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? action1OnPressed;
  final VoidCallback? action2OnPressed;
  // const MyHomeCustomAppBar(
  //     {Key? key, this.onPressed, required this.title, this.leading})
  //     : super(key: key);
  @override
  const MyHomeCustomAppBar(
      {Key? key,
      this.leadingOnPressed,
      this.action1OnPressed,
      this.action2OnPressed})
      : super(key: key);

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
                  MyIconButton(
                      iconWidget:
                          SvgPicture.asset('assets/images/MenuIcon.svg'),
                      onPress: leadingOnPressed),
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
                                'مسقط ,عمان,1988',
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
                      iconWidget:
                          SvgPicture.asset('assets/images/CartIcon.svg'),
                      onPress: action1OnPressed),
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
                      iconWidget:
                          SvgPicture.asset('assets/images/FilterIcon.svg'),
                      onPress: action2OnPressed),
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
