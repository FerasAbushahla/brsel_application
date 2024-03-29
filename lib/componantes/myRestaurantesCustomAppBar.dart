import 'package:brsel_application/componantes/myCartBadgedButton.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/screens/meals.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class MyRestaurantesCustomAppBar extends StatelessWidget {
  // final String title;
  // final Widget? leading;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? action1OnPressed;
  final VoidCallback? action2OnPressed;
  final Widget? leading;
  final String? title;

  // const MyHomeCustomAppBar(
  //     {Key? key, this.onPressed, required this.title, this.leading})
  //     : super(key: key);
  @override
  const MyRestaurantesCustomAppBar({
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
                  // leading!,
                  Container(
                    width: 42,
                  ),
                  Text(
                    title!,
                    style: MyCustomTextStyle.myAppBarTitleTextStyle,
                  ),
                  MyCartBadgedButton(),
                  // MyIconButton(
                  //     BackgroundColor: myBackgroundFillingColor,
                  //     borderRadius: 6,
                  //     iconWidget:
                  //         SvgPicture.asset('assets/images/CartIcon.svg'),
                  //     onPress: action1OnPressed),
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
                        readOnly: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Meals(
                                        focus: true,
                                      )));
                        },
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
