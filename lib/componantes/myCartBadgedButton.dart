import 'package:badges/badges.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/cartController.dart';
import 'package:brsel_application/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyCartBadgedButton extends StatefulWidget {
  const MyCartBadgedButton({
    Key? key,
  }) : super(key: key);

  @override
  State<MyCartBadgedButton> createState() => _MyCartBadgedButtonState();
}

class _MyCartBadgedButtonState extends State<MyCartBadgedButton> {
  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (cartController.cartList.value.length != 0) ...[
            Badge(
              position: BadgePosition(top: 0, start: -0),
              badgeColor: myPrimaryColor,
              badgeContent: Text(
                cartController.cartListLength.value.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 6,
                    fontWeight: FontWeight.w500),
              ),
              child: MyIconButton(
                  BackgroundColor: myBackgroundFillingColor,
                  borderRadius: 6,
                  iconWidget: SvgPicture.asset('assets/images/CartIcon.svg'),
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Cart(),
                        ));
                  }),
            ),
          ] else ...[
            MyIconButton(
                BackgroundColor: myBackgroundFillingColor,
                borderRadius: 6,
                iconWidget: SvgPicture.asset('assets/images/CartIcon.svg'),
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cart(),
                      ));
                }),
          ]
        ],
      ),
    );
  }
}
