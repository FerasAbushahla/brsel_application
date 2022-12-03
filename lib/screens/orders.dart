import 'package:brsel_application/componantes/myDetailsCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/myOrdersCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/orderHistoryController.dart';
import 'package:brsel_application/models/orderHistory.dart';
import 'package:brsel_application/screens/cart.dart';
import 'package:brsel_application/screens/orderDetails.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  OrderHistoryController orderHistoryController =
      Get.put(OrderHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderHistoryController.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    orderHistoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
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
            Expanded(
              child: Obx((() {
                if (OrderHistoryController.isLoading.value) {
                  return SizedBox(
                      // width: 25,
                      height: 96,
                      child: Center(child: CircularProgressIndicator()));
                } else if (orderHistoryController.orderList.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        orderHistoryController.orderList.length,
                        (index) => Padding(
                            padding: index == 0
                                ? EdgeInsets.only(bottom: 6)
                                : EdgeInsets.symmetric(vertical: 6),
                            child: orderCard(
                                orderHistoryController.orderList.value[index])),
                      ),
                    ),
                  );
                } else if (orderHistoryController.orderList.isEmpty) {
                  return Container(
                    height: 100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 40,
                            color: myGreyColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'لا يوجد طلبات في سابقة',
                            style: MyCustomTextStyle.myHintTextStyle,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Icon(
                      Icons.error_outline,
                    ),
                  );
                }
              })),
            ),
          ],
        ),
      ),
    );
  }

  InkWell orderCard(Datum datum) {
    return InkWell(
      onTap: () {
        Get.to(() => OrderDetails());
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: datum.meals!.first.meal!.attachments!.first.link!,

                  // homeResturante.image ??
                  // 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                  imageBuilder: (context, imageProvider) => Container(
                    width: 95,
                    height: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                  placeholder: (context, url) => Container(
                      height: 70,
                      width: 95,
                      child: Center(child: const CircularProgressIndicator())),
                  errorWidget: (context, url, error) => Container(
                    height: 70,
                    width: 95,
                    child: const Icon(
                      Icons.broken_image,
                      color: myGreyColor,
                      size: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          datum.meals!.first.meal!.name!,
                          // 'وجبة برجر',
                          style: MyCustomTextStyle.myCardTitletextStyle,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              datum.meals!.first.meal!.price!,
                              // '15 ر.ع',
                              style: MyCustomTextStyle.myTextButtonTextStyle,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Container(
                              height: 22,
                              width: 60,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1.5,
                                      blurRadius: 1.5,
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      padding: EdgeInsets.all(5),
                                      icon: Icon(
                                        Icons.add,
                                        size: 11.7,
                                        color: myPrimaryColor,
                                      ),
                                      onPressed: null,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: myPrimaryColor),
                                      child: Center(
                                          child: Text(
                                        datum.meals!.first.numberOfMeals!,
                                        // mealDetailsData.count.toString(),
                                        style: MyCustomTextStyle.myCounter,
                                      )),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      padding: EdgeInsets.all(5),
                                      icon: Icon(
                                        Icons.remove,
                                        size: 11.7,
                                        color: myPrimaryColor,
                                      ),
                                      onPressed: null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      // mealDetailsData.description!,
                      datum.meals!.first.meal!.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: MyCustomTextStyle.myH1withOpacityTextStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
