import 'package:brsel_application/componantes/myHomeSecCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/myRestaurantesCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/SearchController.dart';
import 'package:brsel_application/controllers/homeRestaurantsController.dart';
import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/screens/meals.dart';
import 'package:brsel_application/screens/orders.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({Key? key}) : super(key: key);

  @override
  State<Restaurants> createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  HomeRestaurantsController homeRestaurantsController =
      Get.put(HomeRestaurantsController());

  int selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyRestaurantesCustomAppBar(
              title: 'المطاعم',
              // leading: MyIconButton(
              //   onPress: () {
              //     Navigator.pop(context);
              //   },
              //   borderRadius: 12,
              //   BackgroundColor: Colors.white,
              //   iconWidget: Padding(
              //     padding: EdgeInsets.all(5),
              //     child: SvgPicture.asset(
              //       'assets/images/ArrowBack Icon.svg',
              //     ),
              //   ),
              // ),
              action1OnPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Orders(),
                    ));
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // SingleChildScrollView(
                    //   physics: const BouncingScrollPhysics(
                    //       parent: AlwaysScrollableScrollPhysics()),
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: List.generate(
                    //       RestaurantesCategoriesList.length,
                    //       (index) => Padding(
                    //         padding: index == 0
                    //             ? EdgeInsets.only(right: 20)
                    //             : EdgeInsets.only(right: 10),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(6),
                    //               color: myDarkBlueColor),
                    //           child: Padding(
                    //             padding: EdgeInsets.symmetric(
                    //                 horizontal: 8, vertical: 6),
                    //             child: Center(
                    //               child: Text(
                    //                 'مضاف حديثا',
                    //                 style: TextStyle(
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Obx((() {
                      if (HomeRestaurantsController.isLoading.value) {
                        return Container(
                          height: getProportionalScreenHeight(200),
                          child: Center(
                            child: SizedBox(
                                // height: 30,
                                // width: 30,
                                child: CircularProgressIndicator()),
                          ),
                        );
                      } else {
                        return Column(
                          children: List.generate(
                            homeRestaurantsController
                                .homeResraurantsList.length,
                            (index) => Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: RestaurantCard(homeRestaurantsController
                                  .homeResraurantsList[index]),
                            ),
                          ),
                        );
                      }
                    }))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell RestaurantCard(HomeResturante homeResturante) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Meals(
                      focus: false,
                      searchWord: homeResturante.name,
                      // homeMeals: homeMeals,
                      // mealID: '1',
                      // mealID: mealDetailsController.mealID.value,
                      // mealID: homeMeals.id.toString(),
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: homeResturante.image ?? "",
              // imageUrl:
              //     'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
              imageBuilder: (context, imageProvider) => Container(
                width: SizeConfig.screenWidth,
                height: 136,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.fill)),
              ),
              placeholder: (context, url) => SizedBox(
                  height: 136,
                  child: Center(child: const CircularProgressIndicator())),
              errorWidget: (context, url, error) => Container(
                height: 136,
                child: const Icon(
                  Icons.broken_image,
                  color: myGreyColor,
                  size: 30,
                ),
              ),
            ),
            // Image.asset(
            //   'assets/images/Burger.jpg',
            //   fit: BoxFit.fill,
            // ),

            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        homeResturante.name!,
                        // homeMeals.name!,
                        style: MyCustomTextStyle.myAppBarTitleTextStyle,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Icon(
                              BrselApp.locationsecicon,
                              size: 10,
                            ),
                            Text(
                              '2.6',
                              // homeResturante.address!,
                              // homeMeals.price!,
                              style: MyCustomTextStyle.myDetailsSecTextStyle,
                            ),
                            Text(
                              'كم',
                              style: MyCustomTextStyle.myDetailsSecTextStyle,
                            ),
                            VerticalDivider(
                              width: 6,
                              thickness: 1,
                            ),
                            Icon(
                              BrselApp.deliveryicon,
                              size: 10,
                            ),
                            Text(
                              // '20د',
                              '${homeResturante.deliveryTime}د',
                              style: MyCustomTextStyle.myDetailsSecTextStyle,
                            ),
                            Container(
                              width: 6,
                              height: 2,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: myBlackColor),
                            ),
                            VerticalDivider(
                              width: 2,
                              thickness: 1,
                            ),
                            Icon(
                              BrselApp.staricon,
                              size: 10,
                              color: myYellowColor,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              // '3',
                              homeResturante.review!,
                              style: MyCustomTextStyle.myP1,
                            ),
                            Text(
                              '(100)',
                              style: MyCustomTextStyle.myP1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'hjhj',
                    // homeMeals.description!,
                    style: MyCustomTextStyle.myDetailsTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
