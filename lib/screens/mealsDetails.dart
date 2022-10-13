import 'package:brsel_application/componantes/myDetailsCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/mealDetailsController.dart';
import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/models/mealDetailsModel.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MealDetails extends StatefulWidget {
  final String mealID;
  // final HomeMeals? homeMeals;
  const MealDetails({super.key, required this.mealID});

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  List<String> extrasList = [
    "بصل",
    "مخللات",
    "بطاطس مقلية",
    "جبن",
    "زعتر",
    "فلفل"
  ];

  final MealDetailsController mealDetailsController =
      Get.put(MealDetailsController());
  @override
  void initState() {
    // TODO: implement initState
    mealDetailsController.mealID.value = widget.mealID;
    mealDetailsController.getMealDetails();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mealDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MealDetailsController mealDetailsController =
    //     Get.put(MealDetailsController(mealID: widget.mealID));
    print('mealID......${widget.mealID}');
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton:
          //  Expanded(
          // child:

          Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        // constraints: BoxConstraints(
        //   maxWidth: SizeConfig.screenWidth - 30,
        // ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 10,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                decoration: BoxDecoration(
                  color: myPrimaryColor,
                ),
                height: 55,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Text(
                            'إضافة الى السلة',
                            style: MyCustomTextStyle.myButtonTextStyle,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: 100,
                      child: Center(
                        child: Text(
                          '15ر.ع',
                          style: MyCustomTextStyle.myTextButtonTextStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
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
          ),
        ),
      ),

      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          MyDetailsCustomAppBar(
            title: 'تفاصيل الوجبة',
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
                  // MyMealDetailsSlider(homeMeals: widget.homeMeals),
                  Obx((() {
                    if (MealDetailsController.isLoading.value) {
                      return SizedBox(
                          height: 175,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      return MyMealDetailsSlider(
                          mealDetailsData:
                              mealDetailsController.mealDetailsData.value);
                    }
                  })),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1.5,
                            blurRadius: 1.5,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Obx((() {
                                if (MealDetailsController.isLoading.value) {
                                  return SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      )));
                                } else {
                                  return Row(
                                    children: [
                                      Icon(
                                        BrselApp.deliveryicon,
                                        size: 10,
                                      ),
                                      Text(
                                        // '55',
                                        // '${homeMeals.deliveryTime}د',
                                        '${mealDetailsController.mealDetailsData.value.deliveryTime!}د',
                                        // '${widget.homeMeals!.deliveryTime!}د',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: myBlackColor.withOpacity(0.5),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              })),
                              VerticalDivider(
                                width: 0,
                                thickness: 1,
                              ),
                              Obx((() {
                                if (MealDetailsController.isLoading.value) {
                                  return SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      )));
                                } else {
                                  return Text(
                                    // '${homeMeals.deliveryTime}د',
                                    'الحدالأدنى. ${mealDetailsController.mealDetailsData.value.price!} ريال',
                                    // 'الحدالأدنى. ${widget.homeMeals!.price!} ريال',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: myBlackColor.withOpacity(0.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                              })),
                              VerticalDivider(
                                width: 0,
                                thickness: 1,
                              ),
                              Obx((() {
                                if (MealDetailsController.isLoading.value) {
                                  return SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      )));
                                } else {
                                  return Text(
                                    // '${homeMeals.deliveryTime}د',
                                    mealDetailsController
                                        .mealDetailsData.value.restaurant!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: myBlackColor.withOpacity(0.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                              })),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1.5,
                            blurRadius: 1.5,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 11, 0, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Obx((() {
                              if (MealDetailsController.isLoading.value) {
                                return SizedBox(
                                    height: 100,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        mealDetailsController
                                            .mealDetailsData.value.name!,
                                        // widget.homeMeals!.name!,
                                        style: MyCustomTextStyle
                                            .myTitleSecTextStyle,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        'هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف.',
                                        // widget.homeMeals!.description!,
                                        style: MyCustomTextStyle
                                            .myH1withOpacityTextStyle,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            })),
                            Divider(
                              height: 14,
                            ),
                            Obx((() {
                              if (MealDetailsController.isLoading.value) {
                                return SizedBox(
                                    height: 100,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'الإضافات',
                                        style: MyCustomTextStyle
                                            .myTitleSecTextStyle,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        'الرجاء الغاء المواد الغير مطلوبة',
                                        style: MyCustomTextStyle
                                            .myH1withOpacityTextStyle,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      MyMultipleExtrasChips(
                                          extrasList: extrasList),
                                    ],
                                  ),
                                );
                              }
                            })),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Obx((() {
                    if (MealDetailsController.isLoading.value) {
                      return SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 35, 10),
                            child: Text(
                              'إضافات مقترحة',
                              style: MyCustomTextStyle.myTitleSecTextStyle,
                            ),
                          ),
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                mealDetailsController
                                    .mealDetailsData.value.extras!.length,
                                (index) => Padding(
                                  padding: index == 0
                                      ? EdgeInsets.only(right: 35)
                                      : EdgeInsets.only(right: 10),
                                  child: recommendedExtrasCard(
                                    mealsDetailsExtra: mealDetailsController
                                        .mealDetailsData.value.extras![index],
                                    // widget.homeMeals!.extras![index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  })),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Stack recommendedExtrasCard({MealsDetailsExtra? mealsDetailsExtra}) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: 80,
              height: 80,
              child: CachedNetworkImage(
                // imageUrl: homeMealsExtra. ?? "",
                imageUrl:
                    'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                imageBuilder: (context, imageProvider) => Container(
                  width: SizeConfig.screenWidth,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image:
                        DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: const CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  height: 80,
                  child: const Icon(
                    Icons.broken_image,
                    color: myGreyColor,
                    size: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        Positioned(
          // width: 80,
          bottom: 0,
          right: 12,
          child: Container(
            height: 22,
            width: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colors.white),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: myPrimaryColor),
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
                      Icons.add,
                      size: 11.7,
                      color: myPrimaryColor,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MyMultipleExtrasChips extends StatefulWidget {
  final List<String>? extrasList;
  const MyMultipleExtrasChips({super.key, this.extrasList});

  @override
  State<MyMultipleExtrasChips> createState() => _MyMultipleExtrasChipsState();
}

class _MyMultipleExtrasChipsState extends State<MyMultipleExtrasChips> {
  bool isSelected = false;
  List<String> selectedChoices = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoicesList(),
    );
  }

  _buildChoicesList() {
    List<Widget> choices = [];
    widget.extrasList!.forEach((item) {
      choices.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ChoiceChip(
            side: selectedChoices.contains(item)
                ? BorderSide(color: myRedColor, width: 1)
                : BorderSide(color: myBackgroundColor, width: 0),
            backgroundColor: myBackgroundColor,
            selectedColor: myBackgroundColor,
            labelPadding: EdgeInsets.symmetric(horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            label: Text(item,
                style: selectedChoices.contains(item)
                    ? MyCustomTextStyle.myRedH1TextStyle
                    : MyCustomTextStyle.myH1TextStyle),
            selected: selectedChoices.contains(item),
            onSelected: (selected) {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                // isSelected = selected;
                print(selectedChoices);
              });
            },
          ),
        ),
      );
    });
    return choices;
  }
}

class MyMealDetailsSlider extends StatefulWidget {
  // final HomeADsSliderController? homeADsSliderController;
  // final HomeSlider? homeSlider;
  // final HomeMeals? homeMeals;
  final MealDetailsData? mealDetailsData;
  // final Rx<MealDetailsData>? mealDetailsData;

  MyMealDetailsSlider({Key? key, this.mealDetailsData}) : super(key: key);

  @override
  State<MyMealDetailsSlider> createState() => _MyMealDetailsSliderState();
}

class _MyMealDetailsSliderState extends State<MyMealDetailsSlider> {
  // HomeADsSliderController homeADsSliderController =
  //     Get.put(HomeADsSliderController());

  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: List.generate(
            // homeADsSliderController.homeSliderList.length,
            // widget.homeMeals!.attachments!.length,
            widget.mealDetailsData!.attachments!.length,
            (index) => Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: widget.mealDetailsData!.attachments!
                          .elementAt(index)
                          .link ??
                      "",
                  // widget.homeMeals!.attachments!.elementAt(index).link ??
                  //     "",
                  // imageUrl:
                  //     'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                  imageBuilder: (context, imageProvider) => Container(
                    width: SizeConfig.screenWidth,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill)),
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
              ),
            ),
          ),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            },
            autoPlay: true,
            height: getProportionalScreenHeight(170),
            initialPage: current,
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
                "${current + 1}/${widget.mealDetailsData!.attachments!.length}",
                // "${current + 1}/${widget.homeMeals!.attachments!.length}",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
          bottom: 8,
          left: 25,
        ),
        Positioned(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                widget.mealDetailsData!.attachments!.length,
                // widget.homeMeals!.attachments!.length,
                (index) => buildDot(index)),
          ),
          bottom: 10,
          width: SizeConfig.screenWidth,
        )
      ],
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
        duration: kThemeAnimationDuration,
        margin: EdgeInsets.only(
          // top: getProportionalScreenHeight(0),
          left: getProportionalScreenWidth(8),
        ),
        width: current == index ? 8 : 6,
        height: current == index ? 8 : 6,
        decoration: BoxDecoration(
          color: current == index
              ? myPrimaryColor
              : myPrimaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ));
  }
}
