import 'package:brsel_application/componantes/myHomeCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/homeADsSliderController.dart';
import 'package:brsel_application/controllers/homeCategoriesController.dart';
import 'package:brsel_application/controllers/homeMealsController.dart';
import 'package:brsel_application/controllers/homeRestaurantsController.dart';
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
  void initState() {
    // Future.delayed(const Duration(milliseconds: 100), () async {
    //   SharedPreferences preferences = await SharedPreferences.getInstance();
    // });
    super.initState();
  }

  HomeRestaurantsController homeRestaurantsController =
      Get.put(HomeRestaurantsController());
  HomeADsSliderController homeADsSliderController =
      Get.put(HomeADsSliderController());
  HomeCategoriesController homeCategoriesController =
      Get.put(HomeCategoriesController());
  HomeMealsController homeMealsController = Get.put(HomeMealsController());

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
                            onPressed: () {},
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
                            onPressed: () {},
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
                                    childAspectRatio: (1 / 1.18),
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

  Container availableRestautantsCard(HomeResturante homeResturante) {
    return Container(
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
                  image: DecorationImage(image: imageProvider, fit: BoxFit.fill)
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
    );
  }

  InkWell CategoriesCard(HomeCategories homeCategories) {
    return InkWell(
      onTap: () {
        setState(() {
          curruntCategory = homeCategories.id!;
        });
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
              style: MyCustomTextStyle.myCardSecondTitleBlackSecondTextStyle,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              '(13)',
              style: MyCustomTextStyle.myH1withOpacityTextStyle,
            ),
            Text(
              'مطعم',
              style: MyCustomTextStyle.myH1withOpacityTextStyle,
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }
}

final ZoomDrawerController z = ZoomDrawerController();

class HomeZoomDrawer extends StatefulWidget {
  const HomeZoomDrawer({Key? key}) : super(key: key);

  @override
  State<HomeZoomDrawer> createState() => _HomeZoomDrawerState();
}

class _HomeZoomDrawerState extends State<HomeZoomDrawer> {
  String firstName = '';
  String lastName = '';

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    setState(() {
      firstName = preferences.getString("firstName") ?? '';
      print(firstName);
      lastName = preferences.getString("lastName") ?? '';
      print(lastName);
    });

    print(preferences.get('firstName'));
    print(preferences.get('lastName'));
    print(preferences.get('phoneNumber'));
    print(preferences.get('sex'));
    print(preferences.get('token'));
    print(preferences.get('personalImage'));
    print(preferences.get('currentPosition'));
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ZoomDrawer(
      borderRadius: 21,
      controller: z,
      style: DrawerStyle.defaultStyle,
      angle: 0,
      slideWidth: getProportionalScreenWidth(220),
      androidCloseOnBackTap: true,
      mainScreenTapClose: true,
      isRtl: true,
      menuBackgroundColor: Colors.white,
      mainScreenScale: 0.1,
      mainScreen: Home(),
      menuScreen: DrawerMenu(
        firstName: firstName,
        lastName: lastName,
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  final String firstName;
  final String lastName;
  const DrawerMenu({Key? key, required this.firstName, required this.lastName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 55,
            ),
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(7)),
                  child: Image.asset(
                    'assets/images/Profile.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'أهلا بك',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: myGreyColor),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              '$firstName $lastName',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: myBlackColor),
            ),
            SizedBox(
              height: 44,
            ),
            MyMenuListItem(
                title: 'الرئيسية',
                icon: Icon(Icons.home),
                onTap: () {
                  ZoomDrawer.of(context)!.toggle();
                }),
            SizedBox(
              height: 15,
            ),
            MyMenuListItem(
                title: 'طلباتي',
                icon: Icon(BrselApp.ordersicon),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Meals()));
                }),
            SizedBox(
              height: 15,
            ),
            MyMenuListItem(
                title: 'الوجبات',
                icon: Icon(BrselApp.restaurantsicon),
                onTap: () {}),
            SizedBox(
              height: 15,
            ),
            MyMenuListItem(
                title: 'اعدادات',
                icon: Icon(BrselApp.settingsicon),
                onTap: () {}),
            SizedBox(
              height: 15,
            ),
            MyMenuListItem(
                title: 'الدعم والاستعادة',
                icon: Icon(
                  Icons.info_outline,
                  size: 22,
                ),
                onTap: () {}),
            SizedBox(
              height: 15,
            ),
            MyMenuListItem(
                title: 'تسجيل الخروج',
                icon: Icon(BrselApp.logouticon),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'تسجيل الخروج, هل أنت متأكد؟',
                        style:
                            TextStyle(fontSize: getProportionalScreenWidth(16)),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () async {
                            // print('pppppppppppppppppppppppppppp');
                            // SharedPreferences preferences =
                            //     await SharedPreferences.getInstance();
                            // if (true) {
                            //   print('pppppppppppppppppppppppppppp');
                            //   ApiResponse apiResponse =
                            //       await RemoteServices.logOut(
                            //           phone: preferences.getString('phone'),
                            //           token: preferences.getString('token'));
                            //   if (apiResponse.message == 'Unauthenticated') {
                            //     preferences.remove('token');
                            //     preferences.remove('email');
                            //     preferences.remove('first_name');
                            //     preferences.remove('last_name');
                            //     Navigator.pushReplacement(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => WelcomeFormFirst(),
                            //         ));
                            //   }
                            // }
                          },
                          icon: Icon(
                            Icons.logout,
                          ),
                        )
                      ],
                    ),
                  );
                }),
            Spacer(),
            SvgPicture.asset('assets/images/Logo.svg'),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  InkWell MyMenuListItem({String? title, VoidCallback? onTap, Widget? icon}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                icon!,
                SizedBox(
                  width: 15,
                ),
                Text(
                  title!,
                  style: MyCustomTextStyle.myH2,
                ),
              ],
            ),
          ),
        ],
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
