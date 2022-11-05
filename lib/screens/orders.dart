import 'package:brsel_application/componantes/myDetailsCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/myOrdersCustomAppBar.dart';
import 'package:brsel_application/screens/cart.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            // MyDetailsCustomAppBar(
            //   leading: MyIconButton(
            //     onPress: () {
            //       Navigator.pop(context);
            //     },
            //     borderRadius: 12,
            //     BackgroundColor: Colors.white,
            //     iconWidget: Padding(
            //       padding: EdgeInsets.all(5),
            //       child: SvgPicture.asset(
            //         'assets/images/ArrowBack Icon.svg',
            //       ),
            //     ),
            //   ),
            //   title: 'الطلبات',
            // ),
            MyOrdersCustomAppBar(
              title: 'الطلبات',
              leading: MyIconButton(
                onPress: () {
                  Get.back();
                  // Navigator.pop(context);
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
            ),
          ],
        ),
      ),
    );
  }
}
