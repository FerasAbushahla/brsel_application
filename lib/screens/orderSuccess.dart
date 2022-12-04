import 'package:brsel_application/componantes/mySuccessPageButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/cartController.dart';
import 'package:brsel_application/controllers/orderHistoryController.dart';
import 'package:brsel_application/screens/orderDetails.dart';
import 'package:brsel_application/size_config.dart';
import 'package:brsel_application/wraper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  CartController cartController = Get.put(CartController());
  OrderHistoryController orderHistoryController =
      Get.put(OrderHistoryController());
  bool loading = false;

  Future? pushPage(BuildContext context, Widget page) {
    // return Navigator.of(context)
    //     .push<T>(MaterialPageRoute(builder: (context) => page));
    return Get.to(() => Wraper());
  }

  void getCartdata() async {
    await cartController.getCartOrders();
    await cartController.getCartOrdersPrice();
  }

  @override
  void initState() {
    // TODO: implement initState
    // getCartdata;
    cartController.onInit();
    orderHistoryController.onInit();
    super.initState();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   cartController.dispose();
  //   super.dispose();
  // }

  void _moveToHome(BuildContext context) => Get.replace(Wraper());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        await pushPage(context, Wraper());
        return false;
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 130,
            // ),
            SvgPicture.asset(
              'assets/images/sucssesIcon.svg',
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'تم الطلب بنجاح !',
              textAlign: TextAlign.center,
              style: MyCustomTextStyle.mySuccessPageTitleTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                'تم الدفع بنجاح! فقط انتظر أن يصل الطعام إلى المنزل',
                textAlign: TextAlign.center,
                style: MyCustomTextStyle.mySuccessPageTextStyle,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: MySuccessPageButton(
                textColor: Colors.white,
                loading: loading,
                title: 'تتبع الطلب',
                color: myPrimaryColor,
                onPressed: () async {
                  // Get.to(() => OrderDetails(
                  //     orderID: orderHistoryController.orderList.last.id!));
                  Navigator.pushReplacement(
                      Get.context!,
                      MaterialPageRoute(
                          builder: (context) => OrderDetails(
                              fromPaymentPage: true,
                              orderID:
                                  orderHistoryController.orderList.last.id!)));
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: MySuccessPageButton(
                textColor: myBlackColor,
                loading: false,
                title: 'الرجوع للرئيسية',
                color: Colors.white,
                onPressed: () async {
                  await pushPage(context, Wraper());
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
