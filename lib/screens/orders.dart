import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/myOrdersCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/ordersController.dart';
import 'package:brsel_application/models/mealDetailsModel.dart';
import 'package:brsel_application/screens/payment.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  OrdersController ordersController = Get.put(OrdersController());

  // double totalPrice = 0;
  @override
  void initState() {
    // TODO: implement initState
    ordersController.getOrders();
    ordersController.getOrdersPrice();
    print(
        'ordersController.totalprice.value ${ordersController.totalprice.value}');
    // totalPrice = await ordersController.getOrdersPrice();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ordersController.dispose();
    super.dispose();
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
              title: 'طلباتي',
              leading: MyIconButton(
                onPress: () {
                  Navigator.pop(context);
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
                if (OrdersController.isLoading.value) {
                  return SizedBox(
                      // width: 25,
                      height: 96,
                      child: Center(child: CircularProgressIndicator()));
                } else if (ordersController.ordersList.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        ordersController.ordersList.length,
                        (index) => Padding(
                          padding: index == 0
                              ? EdgeInsets.only(bottom: 6)
                              : EdgeInsets.symmetric(vertical: 6),
                          child: orderCard(ordersController.ordersList[index]),
                        ),
                      ),
                    ),
                  );
                } else if (ordersController.ordersList.isEmpty) {
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
                            'لا يوجد طلبات في السلة',
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
              // Spacer(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 0),
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 18, 0, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'ملخص الطلبية',
                        style: MyCustomTextStyle.myCardTitletextStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الإجمالي',
                              style: MyCustomTextStyle.mySearchHintTextStyle,
                            ),
                            Text(
                              '115 ر.ع',
                              style: MyCustomTextStyle.mySearchHintTextStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الإجمالي',
                              style: MyCustomTextStyle.mySearchHintTextStyle,
                            ),
                            Text(
                              '115 ر.ع',
                              style: MyCustomTextStyle.mySearchHintTextStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الإجمالي',
                              style: MyCustomTextStyle.mySearchHintTextStyle,
                            ),
                            Text(
                              '115 ر.ع',
                              style: MyCustomTextStyle.mySearchHintTextStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        color: myPrimaryColor.withOpacity(0.4),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                          child: Row(
                            children: [
                              RawMaterialButton(
                                constraints: BoxConstraints(),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () {},
                                fillColor: myPrimaryColor,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 14.0,
                                ),
                                padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                                shape: CircleBorder(),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'تعديل الكوبون',
                                style: MyCustomTextStyle.myTextButtonTextStyle,
                              ),
                              Spacer(),
                              Text(
                                'تم توفير مبلع 15 ريال عماني',
                                style: MyCustomTextStyle
                                    .myTextButtonLightTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'إجمالي',
                                  style:
                                      MyCustomTextStyle.mySearchHintTextStyle,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      ordersController.totalprice.value
                                          .toString(),
                                      // '210.80',
                                      style: MyCustomTextStyle
                                          .mySearchHintTextStyle,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'ر.ع',
                                      style: MyCustomTextStyle
                                          .mySearchHintTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Payment()));
                              },
                              style: ElevatedButton.styleFrom(
                                // padding: EdgeInsets.symmetric(vertical: 8),
                                padding: EdgeInsets.zero,
                                elevation: 0,
                                backgroundColor: myPrimaryColor,
                                // primary: mySecondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(6, 0, 16, 0),
                                child: Row(
                                  children: [
                                    Text(
                                      'استمرار',
                                      style:
                                          MyCustomTextStyle.myButtonTextStyle,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 2, 3, 2),
                                        child: Icon(
                                          textDirection: TextDirection.ltr,
                                          Icons.arrow_back_ios,
                                          color: myPrimaryColor,
                                          size: 20.0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container orderCard(MealDetailsData mealDetailsData) {
    return Container(
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
                imageUrl: mealDetailsData.attachments!.first.link ?? "",

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
                        mealDetailsData.name!,
                        // 'وجبة برجر',
                        style: MyCustomTextStyle.myCardTitletextStyle,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            mealDetailsData.price!,
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
                                    onPressed: () {},
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: myPrimaryColor),
                                    child: Center(
                                        child: Text(
                                      '1',
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
                                    onPressed: () {},
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
                    'هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف.',
                    maxLines: 2,
                    style: MyCustomTextStyle.myH1withOpacityTextStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
