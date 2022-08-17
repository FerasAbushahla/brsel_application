import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';

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
                      imagePath: 'assets/images/Menu Icon.png',
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
                      imagePath: 'assets/images/Cart Icon.png',
                      onPress: action1OnPressed),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: searchInputDecoration(
                        hint: 'ابحث عن أي مطعم,وجبة أو مطبخ',
                        prefix: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  MyIconButton(
                      imagePath: 'assets/images/Filter Icon.png',
                      onPress: action2OnPressed),
                ],
              ),
              SizedBox(
                height: 9,
              ),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Container(
              //       width: SizeConfig.screenWidth,
              //       child: TextField(
              //         decoration: searchInputDecoration(
              //           hint: 'ابحث عن أي مطعم,وجبة أو مطبخ',
              //           prefix: Icon(Icons.search),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
