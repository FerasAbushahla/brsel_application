import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/SearchController.dart';
import 'package:brsel_application/controllers/homeMealsController.dart';
import 'package:brsel_application/controllers/mealDetailsController.dart';
import 'package:brsel_application/models/SearchModel.dart';
import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/screens/mealsDetails.dart';
import 'package:brsel_application/screens/orders.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../componantes/myHomeSecCustomAppBar.dart';
import '../componantes/myIconButton.dart';

class Meals extends StatefulWidget {
  final bool focus;
  final String? searchWord;
  const Meals({Key? key, required this.focus, this.searchWord})
      : super(key: key);

  @override
  State<Meals> createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  FocusNode myFocusNode = FocusNode();
  // HomeMealsController homeMealsController = Get.put(HomeMealsController());
  SearchController searchController = Get.put(SearchController());
  MealDetailsController mealDetailsController =
      Get.put(MealDetailsController());
  TextEditingController searchFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      searchFieldController.text =
          (widget.searchWord == null ? "" : widget.searchWord)!;
      searchController.getSearchMeals(
          word: widget.searchWord == null ? "" : widget.searchWord);
      if (widget.focus) {
        FocusScope.of(context).requestFocus(myFocusNode);
      }
      // searchController.getSearchMeals(word: "");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
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
            MyHomeSecCustomAppBar(
              action1OnPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Orders(),
                    ));
              },
              focus: widget.focus,
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
              searchBar: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      child: TextField(
                        controller: searchFieldController,
                        focusNode: myFocusNode,
                        style: MyCustomTextStyle.myH1TextStyle,
                        decoration: searchInputDecoration(
                          hint: 'ابحث عن أي مطعم,وجبة أو مطبخ',
                          prefix: Icon(
                            BrselApp.searchicon,
                            size: 17,
                            color: myPrimaryColor,
                          ),
                        ),
                        onChanged: ((value) {
                          searchController.getSearchMeals(
                              word: searchFieldController.text);
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  MyIconButton(
                      BackgroundColor: myBackgroundFillingColor,
                      borderRadius: 6,
                      iconWidget:
                          SvgPicture.asset('assets/images/FilterIcon.svg'),
                      onPress: () {}),
                ],
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
                        if (SearchController.isLoading.value) {
                          return Container(
                              height: 150,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else if (searchController.searchList.isNotEmpty) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: searchController.searchList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: (1 / 1.18),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) => searchMealsCard(
                                searchController.searchList[index]),
                          );
                        } else if (searchController.searchList.isEmpty) {
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
                                    'لا يوجد وجبات بهذه المواصفات',
                                    style: MyCustomTextStyle.myHintTextStyle,
                                  )
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
            )
          ],
        ),
      ),
    );
  }

  InkWell searchMealsCard(SearchData searchData) {
    return InkWell(
      onTap: () {
        mealDetailsController.mealID.value = searchData.id.toString();
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
                offset: Offset(0, 0),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: searchData.attachments!.first.link ?? "",
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
                        searchData.name!,
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
                            searchData.review!,
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
                    searchData.description!,
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
                        '${searchData.deliveryTime}د',
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
                        searchData.price!,
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
