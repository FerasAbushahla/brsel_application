import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/myOrdersCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/controllers/homeADsSliderController.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Ads extends StatefulWidget {
  const Ads({super.key});

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  HomeADsSliderController homeADsSliderController =
      Get.put(HomeADsSliderController());
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
              title: 'العروض',
              leading: MyIconButton(
                onPress: () {
                  Get.back();
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
                if (HomeADsSliderController.isLoading.value) {
                  return SizedBox(
                      // width: 25,
                      height: 96,
                      child: Center(child: CircularProgressIndicator()));
                } else if (homeADsSliderController.homeSliderList.isNotEmpty) {
                  return SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      homeADsSliderController.homeSliderList.length,
                      (index) => Padding(
                        padding: index == 0
                            ? EdgeInsets.only(bottom: 6)
                            : EdgeInsets.symmetric(vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl: homeADsSliderController
                                      .homeSliderList[index].image ??
                                  "",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: SizeConfig.screenWidth,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill)),
                              ),
                              placeholder: (context, url) => Center(
                                  child: const CircularProgressIndicator()),
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
                    ),
                  ));
                } else if (homeADsSliderController.homeSliderList.isEmpty) {
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
                            'لا يوجد عروض حالياً',
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
}
