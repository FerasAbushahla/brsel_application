import 'package:brsel_application/componantes/driver/myDriverHomeCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyDriverHomeCustomAppBar(),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: TabBar(
                      controller: _tabController,
                      labelStyle:
                          MyCustomTextStyle.myTabBarSelectedLabelTextStyle,
                      unselectedLabelStyle:
                          MyCustomTextStyle.myTabBarUnSelectedLabelTextStyle,
                      labelPadding: EdgeInsets.symmetric(vertical: 7),
                      tabs: [
                        Text(
                          'الطلبات الحالية',
                        ),
                        Text(
                          'الطلبات الواردة',
                        ),
                        Text(
                          'الطلبات المسلمة',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                9,
                                (index) => Padding(
                                  padding:
                                      //  index == 0
                                      //     ? EdgeInsets.only(bottom: 6)
                                      // :
                                      EdgeInsets.symmetric(vertical: 6),
                                  child: orderCard(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: mySecondaryColor,
                        ),
                        Container(
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container orderCard() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(17, 22, 22, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: myPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    size: 14,
                    Icons.location_on_outlined,
                    color: Colors.white,
                  ),
                )
                // SvgPicture.asset(
                //   'assets/images/Gallery.svg',
                //   color: myPrimaryColor,
                //   height: getProportionalScreenHeight(60),
                // ),
                ),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(6),
            //   child: CachedNetworkImage(
            //     imageUrl:
            //         'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
            //     // mealElement!.meal!.attachments!.first.link!,

            //     // imageUrl:
            //     //     // homeResturante.image ??
            //     //     'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
            //     imageBuilder: (context, imageProvider) => Container(
            //       width: 60,
            //       height: 45,
            //       decoration: BoxDecoration(
            //           image: DecorationImage(
            //               image: imageProvider, fit: BoxFit.cover)),
            //     ),
            //     placeholder: (context, url) => Container(
            //         height: 60,
            //         width: 45,
            //         child: Center(child: const CircularProgressIndicator())),
            //     errorWidget: (context, url, error) => Container(
            //       height: 70,
            //       width: 95,
            //       child: const Icon(
            //         Icons.broken_image,
            //         color: myGreyColor,
            //         size: 30,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    // mealElement.meal!.name!,
                    'مسقط ,عمان,1988',
                    style: MyCustomTextStyle.myH2TextStyle,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    ' شارع البغداد, حي الجنينية رقم 22 البناية رقم 15 ',
                    // mealElement.meal!.description!,
                    // mealDetailsData.description!,
                    // datum.meals!.first.meal!.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MyCustomTextStyle.myP1WithOpacity,
                  ),
                ],
              ),
            ),
            // Spacer(),

            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    // mealElement.meal!.name!,
                    '#100182454',
                    style: MyCustomTextStyle.myH2TextStyle,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    '17:50-14/07/2022',
                    // mealElement.meal!.description!,
                    // mealDetailsData.description!,
                    // datum.meals!.first.meal!.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MyCustomTextStyle.myDriverDteTextStyle,
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
