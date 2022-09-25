import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/homeMealsController.dart';
import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/screens/mealsDetails.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../componantes/myHomeSecCustomAppBar.dart';
import '../componantes/myIconButton.dart';

class Meals extends StatefulWidget {
  const Meals({Key? key}) : super(key: key);

  @override
  State<Meals> createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  HomeMealsController homeMealsController = Get.put(HomeMealsController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyHomeSecCustomAppBar(
              title: 'الوجبات',
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Obx((() {
                        if (HomeMealsController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: homeMealsController.homeMealsList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: (1 / 1.18),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) => homeMeals(
                                homeMealsController.homeMealsList[index]),
                          );
                        }
                      })),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell homeMeals(HomeMeals homeMeals) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MealDetails(
                      homeMeals: homeMeals,
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
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: homeMeals.attachments!.first.link ?? "",
              imageBuilder: (context, imageProvider) => Container(
                width: SizeConfig.screenWidth,
                height: 123,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.fill)),
              ),
              placeholder: (context, url) => SizedBox(
                  height: 123,
                  child: Center(child: const CircularProgressIndicator())),
              errorWidget: (context, url, error) => Container(
                height: 123,
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
              padding: EdgeInsets.fromLTRB(10, 6, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        homeMeals.name!,
                        style: MyCustomTextStyle.myH3,
                      ),
                      Row(
                        children: [
                          Icon(
                            BrselApp.staricon,
                            size: 10,
                            color: myYellowColor,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            homeMeals.review!,
                            style: MyCustomTextStyle.myP1,
                          ),
                          Text(
                            '(100)',
                            style: MyCustomTextStyle.myP1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    homeMeals.description!,
                    style: MyCustomTextStyle.myDetailsTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        BrselApp.deliveryicon,
                        size: 10,
                      ),
                      Text(
                        '${homeMeals.deliveryTime}د',
                        style: MyCustomTextStyle.myDetailsSecTextStyle,
                      ),
                      Container(
                        width: 2,
                        height: 2,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: myBlackColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'الحدالأدنى.',
                        style: MyCustomTextStyle.myDetailsSecTextStyle,
                      ),
                      Text(
                        homeMeals.price!,
                        style: MyCustomTextStyle.myDetailsSecTextStyle,
                      ),
                      Text(
                        'ريال',
                        style: MyCustomTextStyle.myDetailsSecTextStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
