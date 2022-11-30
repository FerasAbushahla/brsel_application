import 'dart:convert';

import 'package:brsel_application/componantes/myHomeCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/SearchController.dart';
import 'package:brsel_application/controllers/homeADsSliderController.dart';
import 'package:brsel_application/controllers/homeCategoriesController.dart';
import 'package:brsel_application/controllers/homeMealsController.dart';
import 'package:brsel_application/controllers/homeRestaurantsController.dart';
import 'package:brsel_application/controllers/mealDetailsController.dart';
import 'package:brsel_application/controllers/cartController.dart';
import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/screens/meals.dart';
import 'package:brsel_application/screens/mealsDetails.dart';
import 'package:brsel_application/screens/restaurants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSharedPreferences();
  }

  // void initState() {
  //   Future.delayed(const Duration(milliseconds: 100), () async {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     preferences.setBool("userPersonalInfoDone", true);
  //     print("currentPosition ${preferences.get('currentPosition')}");
  //     print("firstName ${preferences.get('firstName')}");
  //     print("lastName ${preferences.get('lastName')}");
  //     print("sex ${preferences.get('sex')}");
  //     print("personalImage ${preferences.get('personalImage')}");
  //     print(
  //         "currentPositionLatitude ${preferences.get('currentPositionLatitude')}");
  //     print(
  //         "currentPositionLongitude ${preferences.get('currentPositionLongitude')}");
  //     print("phoneNumber ${preferences.get('phoneNumber')}");
  //     print("ID ${preferences.get('ID')}");
  //     print("token ${preferences.get('token')}");
  //     // LocaleDBHelper.dbHelper.deleteOrdersLocal();
  //   });
  //   super.initState();
  // }
  Future setSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("userPersonalInfoDone", true);
  }

  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  final ZoomDrawerController z = ZoomDrawerController();
  CartController cartController = Get.put(CartController());
  HomeRestaurantsController homeRestaurantsController =
      Get.put(HomeRestaurantsController());
  HomeADsSliderController homeADsSliderController =
      Get.put(HomeADsSliderController());
  HomeCategoriesController homeCategoriesController =
      Get.put(HomeCategoriesController());
  HomeMealsController homeMealsController = Get.put(HomeMealsController());
  MealDetailsController mealDetailsController =
      Get.put(MealDetailsController());
  SearchController searchController = Get.put(SearchController());

  // final drawerController = ZoomDrawerController();
  int curruntCategory = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyHomeCustomAppBar(
              leading: MyIconButton(
                  BackgroundColor: myBackgroundFillingColor,
                  borderRadius: 6,
                  iconWidget: SvgPicture.asset('assets/images/MenuIcon.svg'),
                  onPress: () {
                    ZoomDrawer.of(context)!.toggle();
                  }),
              // action1OnPressed: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => Cart(),
              //       ));
              // },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.white,
                      width: SizeConfig.screenWidth,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'العروض(130)',
                                    style: MyCustomTextStyle.myH2,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'تصفح الكل',
                                      style: MyCustomTextStyle.myGreenTextStyle,
                                    ),
                                    style: TextButton.styleFrom(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.centerLeft),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // Container(
                            //   width: SizeConfig.screenWidth,
                            //   height: 170,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(6),
                            //   ),
                            //   child: Image.asset(
                            //     'assets/images/Ad.jpg',
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                            Obx(() {
                              if (HomeADsSliderController.isLoading.value) {
                                print('HomeADsSliderController.isLoading');
                                return Container(
                                  height: getProportionalScreenHeight(170),
                                  child: Center(
                                    child: SizedBox(
                                        // height: 30,
                                        // width: 30,
                                        child: CircularProgressIndicator()),
                                  ),
                                );
                              } else {
                                print('HomeADsSliderController.doneLoading');
                                return MyADSlider(
                                    // homeADsSliderController:
                                    //     homeADsSliderController,

                                    );
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'المطاعم المتوفرة(120)',
                            style: MyCustomTextStyle.myH2,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Restaurants()));
                            },
                            child: Text(
                              'تصفح الكل',
                              style: MyCustomTextStyle.myGreenTextStyle,
                            ),
                            style: TextButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx((() {
                      if (HomeRestaurantsController.isLoading.value) {
                        return SizedBox(
                            // width: 25,
                            height: 95,
                            child: Center(child: CircularProgressIndicator()));
                      } else {
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              homeRestaurantsController
                                  .homeResraurantsList.length,
                              (index) => Padding(
                                padding: index == 0
                                    ? EdgeInsets.only(right: 20)
                                    : EdgeInsets.only(right: 10),
                                child: availableRestautantsCard(
                                    homeRestaurantsController
                                        .homeResraurantsList[index]),
                              ),
                            ),
                          ),
                        );
                      }
                    })),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الأصناف',
                            style: MyCustomTextStyle.myH2,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Meals(
                                            focus: false,
                                          )));
                            },
                            child: Text(
                              'مشاهدة الكل',
                              style: MyCustomTextStyle.myGreenTextStyle,
                            ),
                            style: TextButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx((() {
                      if (HomeCategoriesController.isLoading.value) {
                        return SizedBox(
                            // width: 25,
                            height: 96,
                            child: Center(child: CircularProgressIndicator()));
                      } else {
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              homeCategoriesController
                                  .homeCategoriesList.length,
                              (index) => Padding(
                                padding: index == 0
                                    ? EdgeInsets.only(right: 20)
                                    : EdgeInsets.only(right: 10),
                                child: CategoriesCard(homeCategoriesController
                                    .homeCategoriesList[index]),
                              ),
                            ),
                          ),
                        );
                      }
                    })),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الوجبات الرائجة',
                            style: MyCustomTextStyle.myH2,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Meals(
                                            focus: false,
                                          )));
                            },
                            child: Text(
                              'مشاهدة الكل',
                              style: MyCustomTextStyle.myGreenTextStyle,
                            ),
                            style: TextButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                                    childAspectRatio: (1 / 1.1),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) => homeMeals(
                                homeMealsController.homeMealsList[index]),
                          );
                        }
                      })),
                    ),
                    SizedBox(
                      height: 15,
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
        print('card tap');
        print(homeMeals.id);
        mealDetailsController.mealID.value = homeMeals.id.toString();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MealDetails(
                      // homeMeals: homeMeals,
                      // mealID: '1',
                      mealID: mealDetailsController.mealID.value,
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
                offset: Offset(0, 3),
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
            Padding(
              padding: EdgeInsets.fromLTRB(10, 6, 10, 0),
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
                    overflow: TextOverflow.ellipsis,
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

  InkWell availableRestautantsCard(HomeResturante homeResturante) {
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
        width: 76,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: homeResturante.image ?? "",
              // imageUrl: homeResturante.image ??
              //     'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
              imageBuilder: (context, imageProvider) => Container(
                width: SizeConfig.screenWidth,
                height: 76,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image:
                        DecorationImage(image: imageProvider, fit: BoxFit.fill)
                    // DecorationImage(
                    //   fit: BoxFit.cover,
                    //   // image: NetworkImage(homeResturante.image!),
                    //   image: CachedNetworkImageProvider(
                    //     homeResturante.image ??
                    //         'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                    //     errorListener: () => const Icon(Icons.broken_image_outlined),
                    //   ),
                    // ),
                    ),
              ),
              placeholder: (context, url) =>
                  Center(child: const CircularProgressIndicator()),
              errorWidget: (context, url, error) => Container(
                height: 76,
                child: const Icon(
                  Icons.broken_image,
                  color: myGreyColor,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              homeResturante.name!,
              style: MyCustomTextStyle.myCardTitleBlackSecondTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  InkWell CategoriesCard(HomeCategories homeCategories) {
    return InkWell(
      onTap: () {
        setState(() {
          curruntCategory = homeCategories.id!;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Meals(
                      focus: false,
                      searchWord: homeCategories.name,
                    )));
      },
      child: Container(
        width: 57,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: curruntCategory == homeCategories.id!
                ? myPrimaryColor
                : Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/burger1.png',
              fit: BoxFit.contain,
              width: 50,
              height: 45,
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              homeCategories.name!,
              style: curruntCategory == homeCategories.id!
                  ? MyCustomTextStyle
                      .myCardSecondTitleBlackClickedSecondTextStyle
                  : MyCustomTextStyle.myCardSecondTitleBlackSecondTextStyle,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              '(13)',
              style: curruntCategory == homeCategories.id!
                  ? MyCustomTextStyle
                      .myCardSecondTitleBlackClickedSecondTextStyle
                  : MyCustomTextStyle.myH1withOpacityTextStyle,
            ),
            Text(
              'وجبة',
              style: curruntCategory == homeCategories.id!
                  ? MyCustomTextStyle
                      .myCardSecondTitleBlackClickedSecondTextStyle
                  : MyCustomTextStyle.myH1withOpacityTextStyle,
            ),
            SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}

class MyADSlider extends StatefulWidget {
  // final HomeADsSliderController? homeADsSliderController;
  // final HomeSlider? homeSlider;

  const MyADSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<MyADSlider> createState() => _MyADSliderState();
}

class _MyADSliderState extends State<MyADSlider> {
  HomeADsSliderController homeADsSliderController =
      Get.put(HomeADsSliderController());

  int currentAd = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: List.generate(
            homeADsSliderController.homeSliderList.length,
            (index) => Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl:
                      homeADsSliderController.homeSliderList[index].image ?? "",
                  // imageUrl: homeResturante.image ??
                  //     'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                  imageBuilder: (context, imageProvider) => Container(
                    width: SizeConfig.screenWidth,
                    height: 76,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill)
                        // DecorationImage(
                        //   fit: BoxFit.cover,
                        //   // image: NetworkImage(homeResturante.image!),
                        //   image: CachedNetworkImageProvider(
                        //     homeResturante.image ??
                        //         'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                        //     errorListener: () => const Icon(Icons.broken_image_outlined),
                        //   ),
                        // ),
                        ),
                  ),
                  placeholder: (context, url) =>
                      Center(child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Container(
                    height: 76,
                    child: const Icon(
                      Icons.broken_image,
                      color: myGreyColor,
                      size: 30,
                    ),
                  ),
                ),
                //  Container(
                //   width: SizeConfig.screenWidth,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(6),
                //   ),
                //   child: Image.asset(
                //     'assets/images/Ad.jpg',
                //     fit: BoxFit.fill,
                //   ),
                //   // child: NetworkImage(
                //   //   widget.homeSlider.attachments
                //   // ),
                // ),
              ),
            ),
          ),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                currentAd = index;
              });
            },
            autoPlay: true,
            height: getProportionalScreenHeight(170),
            initialPage: currentAd,
            reverse: false,
            enableInfiniteScroll: false,
            viewportFraction: 1,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: myBlackColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 1, color: Colors.white),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(7, 1, 7, 1),
              child: Text(
                "${currentAd + 1}/${homeADsSliderController.homeSliderList.length}",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
          bottom: 15,
          right: 25,
        )
      ],
    );
  }
}
