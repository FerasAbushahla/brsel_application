import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/componantes/myCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/mySuccessPageButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/screens/register.dart';
import 'package:brsel_application/size_config.dart';
import 'package:brsel_application/wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  bool loading = false;

  Future<T?> pushPage<T>(BuildContext context, Widget page) {
    return Navigator.of(context)
        .push<T>(MaterialPageRoute(builder: (context) => page));
  }

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
        // appBar: MyCustomAppBar(
        //   leading: Column(
        //     children: [
        //       SizedBox(
        //         height: 11,
        //       ),
        //       MyIconButton(
        //         onPress: () {
        //           Get.back();

        //           // Navigator.pop(context);
        //         },
        //         borderRadius: 12,
        //         BackgroundColor: Colors.white,
        //         iconWidget: Padding(
        //           padding: EdgeInsets.all(5),
        //           child: SvgPicture.asset(
        //             'assets/images/ArrowBack Icon.svg',
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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
                onPressed: () {},
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
                onPressed: () {},
              ),
            ),
          ],
        )),
      ),
    );
  }
}
