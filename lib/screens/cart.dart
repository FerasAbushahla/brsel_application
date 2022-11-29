import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/myOrdersCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/cartController.dart';
import 'package:brsel_application/models/mealDetailsModel.dart';
import 'package:brsel_application/screens/payment.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Cart extends StatefulWidget {
  Cart({
    Key? key,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartController cartController = Get.put(CartController());
  double totalWhithFees = 20;
  bool isButtonDisabled = true;

  late Box orderBox;

  void getCartdata() async {
    await cartController.getCartOrders();
    await cartController.getCartOrdersPrice();
  }

  // double totalPrice = 0;
  @override
  void initState() {
    // TODO: implement initState

    // print('Get.currentRoute${ModalRoute.of(context)?.settings.name}');
    cartController.onInit();
    getCartdata();
    cartController.totalprice;
    cartController.cartListLength;
    if (cartController.totalprice > 0) {
      setState(() {
        isButtonDisabled = false;
      });
    } else {
      setState(() {
        isButtonDisabled = true;
      });
    }
    print(
        'ordersController.totalprice.value ${cartController.totalprice.value}');
    // totalPrice = await ordersController.getOrdersPrice();
    super.initState();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   cartController.dispose();
  //   super.dispose();
  // }

  // void deleteOrder(int index) async {
  //   await LocaleDBHelper.dbHelper.deleteOrder(index);
  // }

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
              title: 'السلة',
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
                if (CartController.isLoading.value) {
                  return SizedBox(
                      // width: 25,
                      height: 96,
                      child: Center(child: CircularProgressIndicator()));
                } else if (cartController.cartList.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        cartController.cartList.length,
                        (index) => Padding(
                          padding: index == 0
                              ? EdgeInsets.only(bottom: 6)
                              : EdgeInsets.symmetric(vertical: 6),
                          child: Slidable(
                              useTextDirection: false,
                              key: ValueKey(1),
                              startActionPane: ActionPane(
                                extentRatio: 0.3,
                                motion: ScrollMotion(),
                                // dismissible:
                                //     DismissiblePane(onDismissed: () {}),
                                children: [
                                  CustomSlidableAction(
                                    onPressed: ((context) async {
                                      print(
                                          cartController.cartList[index].price);
                                      cartController.deleteOrder(index);
                                      // await LocaleDBHelper.dbHelper
                                      //     .deleteOrder(index);
                                      // ordersController.getOrders();
                                      // ordersController.totalprice;
                                    }),
                                    backgroundColor: myBackgroundColor,
                                    foregroundColor: myRedColor,
                                    child: Icon(
                                      Icons.delete,
                                      size: 40,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    autoClose: true,
                                  ),
                                ],
                              ),
                              // endActionPane: ActionPane(
                              //   // extentRatio: 0.5,
                              //   motion: ScrollMotion(),
                              //   dismissible:
                              //       DismissiblePane(onDismissed: () {}),
                              //   children: [
                              //     // SlidableAction(
                              //     //   onPressed: doNothing,
                              //     //   backgroundColor: Color(0xFFFE4A49),
                              //     //   foregroundColor: Colors.white,
                              //     //   icon: Icons.delete,
                              //     //   label: 'Delete',
                              //     // ),
                              //     CustomSlidableAction(
                              //       onPressed: doNothing,
                              //       backgroundColor: myBackgroundColor,
                              //       foregroundColor: myRedColor,
                              //       child: Icon(
                              //         Icons.delete,
                              //         size: 40,
                              //       ),
                              //       borderRadius: BorderRadius.circular(8),
                              //       autoClose: true,
                              //     ),
                              //   ],
                              // ),
                              child: orderCard(cartController.cartList[index])),
                        ),
                      ),
                    ),
                  );
                } else if (cartController.cartList.isEmpty) {
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
            Obx((() {
              if (cartController.cartList.isEmpty) {
                return Container();
              } else {
                return Align(
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
                                  style:
                                      MyCustomTextStyle.mySearchHintTextStyle,
                                ),
                                Row(
                                  children: [
                                    Obx(() {
                                      if (CartController.isLoading.value) {
                                        return Container(
                                          height:
                                              getProportionalScreenHeight(5),
                                          // child: Center(
                                          //   child: SizedBox(
                                          //       // height: 30,
                                          //       // width: 30,
                                          //       child: CircularProgressIndicator()),
                                          // ),
                                        );
                                      } else {
                                        return Text(
                                          cartController.totalprice.value
                                              .toString(),
                                          // '210.80',
                                          style: MyCustomTextStyle
                                              .mySearchHintTextStyle,
                                        );
                                      }
                                    }),
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
                                  'رسوم التوصيل',
                                  style:
                                      MyCustomTextStyle.mySearchHintTextStyle,
                                ),
                                Text(
                                  '20 ر.ع',
                                  style:
                                      MyCustomTextStyle.mySearchHintTextStyle,
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 6,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 25),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         'كوبون خصم',
                          //         style: MyCustomTextStyle.mySearchHintTextStyle,
                          //       ),
                          //       Text(
                          //         '15 ر.ع',
                          //         style: MyCustomTextStyle.mySearchHintTextStyle,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 12,
                          ),
                          // Container(
                          //   width: SizeConfig.screenWidth,
                          //   color: myPrimaryColor.withOpacity(0.4),
                          //   child: Padding(
                          //     padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                          //     child: Row(
                          //       children: [
                          //         RawMaterialButton(
                          //           constraints: BoxConstraints(),
                          //           materialTapTargetSize:
                          //               MaterialTapTargetSize.shrinkWrap,
                          //           onPressed: () {},
                          //           fillColor: myPrimaryColor,
                          //           child: Icon(
                          //             Icons.edit,
                          //             color: Colors.white,
                          //             size: 14.0,
                          //           ),
                          //           padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                          //           shape: CircleBorder(),
                          //         ),
                          //         SizedBox(
                          //           width: 5,
                          //         ),
                          //         Text(
                          //           'تعديل الكوبون',
                          //           style: MyCustomTextStyle.myTextButtonTextStyle,
                          //         ),
                          //         Spacer(),
                          //         Text(
                          //           'تم توفير مبلع 15 ريال عماني',
                          //           style: MyCustomTextStyle
                          //               .myTextButtonLightTextStyle,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
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
                                      style: MyCustomTextStyle
                                          .mySearchHintTextStyle,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Obx(
                                          () => Text(
                                            '${cartController.totalprice.value + totalWhithFees}',
                                            // '210.80',
                                            style: MyCustomTextStyle
                                                .mySearchHintTextStyle,
                                          ),
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
                                Obx(
                                  () => ElevatedButton(
                                    onPressed:
                                        cartController.isButtonDisabled.value
                                            ? null
                                            : () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Payment()));
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
                                      padding: const EdgeInsets.fromLTRB(
                                          6, 0, 16, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'استمرار',
                                            style: MyCustomTextStyle
                                                .myButtonTextStyle,
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
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 2, 3, 2),
                                              child: Icon(
                                                textDirection:
                                                    TextDirection.ltr,
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
            })),
          ],
        ),
      ),
    );
  }

  Container orderCard(MealDetailsData mealDetailsData) {
    String mealCount = mealDetailsData.count.toString();
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
                                    onPressed: () async {
                                      orderBox = Hive.box('orderBox');
                                      Map<String, dynamic> mealWithCounter =
                                          mealDetailsData.toJson();
                                      int count = await cartController
                                          .getMealCount(mealDetailsData.id!);
                                      int index = await cartController
                                          .getIndex(mealDetailsData.id!);

                                      mealWithCounter['count'] = count += 1;
                                      await orderBox.putAt(
                                          index, mealWithCounter);
                                      setState(() {
                                        getCartdata();
                                        // mealWithCounter;
                                        // mealDetailsData.count;
                                        // mealDetailsData;
                                        print(
                                            'mealWithCounter $mealWithCounter');
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: myPrimaryColor),
                                    child: Center(
                                        child: Text(
                                      mealCount,
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
                                    onPressed: () async {
                                      orderBox = Hive.box('orderBox');
                                      Map<String, dynamic> mealWithCounter =
                                          mealDetailsData.toJson();
                                      int count = await cartController
                                          .getMealCount(mealDetailsData.id!);
                                      int index = await cartController
                                          .getIndex(mealDetailsData.id!);

                                      mealWithCounter['count'] = count -= 1;
                                      mealWithCounter['count'] < 1
                                          ? mealWithCounter['count'] = 1
                                          : mealWithCounter['count'];
                                      await orderBox.putAt(
                                          index, mealWithCounter);
                                      setState(() {
                                        getCartdata();
                                        // mealWithCounter;
                                        // mealDetailsData.count;
                                        // mealDetailsData;
                                        print(
                                            'mealWithCounter $mealWithCounter');
                                      });
                                    },
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
