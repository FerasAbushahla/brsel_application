import 'package:brsel_application/componantes/myDetailsCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MealDetails extends StatefulWidget {
  const MealDetails({super.key});

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
                  MyMealDetailsSlider(),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class MyMealDetailsSlider extends StatefulWidget {
  // final HomeADsSliderController? homeADsSliderController;
  // final HomeSlider? homeSlider;

  const MyMealDetailsSlider({
    Key? key,
  }) : super(key: key);

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
            2,
            (index) => Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  // imageUrl:
                  //     homeADsSliderController.homeSliderList[index].image ?? "",
                  imageUrl:
                      'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
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
                "${current + 1}/2",
                // "${currentAd + 1}/${homeADsSliderController.homeSliderList.length}",
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
            children: List.generate(2, (index) => buildDot(index)),
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
