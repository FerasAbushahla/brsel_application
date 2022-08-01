import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants.dart';

class MyHomeCustomAppBar extends StatelessWidget {
  @override
  // final String title;
  // final Widget? leading;
  // final VoidCallback? onPressed;
  // const MyHomeCustomAppBar(
  //     {Key? key, this.onPressed, required this.title, this.leading})
  //     : super(key: key);
  const MyHomeCustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 11, 20, 0),
      child: Container(
        height: getProportionalScreenHeight(124),
        width: SizeConfig.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyIconButton(
                    imagePath: 'assets/images/Menu Icon.png', onPress: () {}),
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
                              style: MyCustomTextStyle.myH1withOpacityTextStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                MyIconButton(
                    imagePath: 'assets/images/Cart Icon.png', onPress: () {}),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
