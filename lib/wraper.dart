import 'package:brsel_application/componantes/HomeZoomDrawer.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/screens/meals.dart';
import 'package:brsel_application/screens/orders.dart';
import 'package:brsel_application/screens/restaurants.dart';
import 'package:brsel_application/screens/settings.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Wraper extends StatefulWidget {
  final int? currentPageGlobale;
  const Wraper({Key? key, this.currentPageGlobale}) : super(key: key);
  // const Wraper({Key? key}) : super(key: key);

  @override
  State<Wraper> createState() => _WraperState();
}

class _WraperState extends State<Wraper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.currentPageGlobale == 0) {
      setState(() {
        currentPage = 0;
        currentScreen = HomeZoomDrawer();
      });
    } else if (widget.currentPageGlobale == 1) {
      setState(() {
        currentPage = 1;
        currentScreen = Orders();
      });
    } else if (widget.currentPageGlobale == 2) {
      setState(() {
        currentPage = 2;
        currentScreen = Meals(
          focus: false,
        );
      });
    } else if (widget.currentPageGlobale == 3) {
      setState(() {
        currentPage = 3;
        currentScreen = Restaurants();
      });
    } else if (widget.currentPageGlobale == 4) {
      setState(() {
        currentPage = 4;
        currentScreen = Settings();
      });
    } else {
      setState(() {
        currentPage = 0;
        currentScreen = HomeZoomDrawer();
      });
    }
  }

  int currentPage = 0;
  final List<Widget> Screens = [
    HomeZoomDrawer(),
    // Home(),
    Orders(),
    Meals(focus: false),
    Restaurants(),
    Settings(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeZoomDrawer();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: SizedBox(
          width: 46.5,
          height: 46.5,
          child: FittedBox(
            child: Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
              child: FloatingActionButton(
                backgroundColor: myPrimaryColor,
                child: Icon(
                  size: 30,
                  Icons.add_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    currentPage = 2;
                    currentScreen = Meals(
                      focus: false,
                    );
                  });
                },
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 0,
          child: Container(
            width: SizeConfig.screenWidth,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 77,
                      onPressed: () {
                        setState(() {
                          currentPage = 0;
                          currentScreen = HomeZoomDrawer();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/homeIcon.svg',
                            color:
                                currentPage == 0 ? myPrimaryColor : myGreyColor,
                          ),
                          // Icon(
                          //   Icons.home_outlined,
                          //   size: 25,
                          //   color:
                          //       currentPage == 0 ? myPrimaryColor : myGreyColor,
                          // ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'الرئيسية',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: currentPage == 0
                                    ? myPrimaryColor
                                    : myGreyColor),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 77,
                      onPressed: () {
                        setState(() {
                          currentPage = 1;
                          currentScreen = Orders();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            BrselApp.ordersicon,
                            size: 25,
                            color:
                                currentPage == 1 ? myPrimaryColor : myGreyColor,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'طلباتي',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: currentPage == 1
                                    ? myPrimaryColor
                                    : myGreyColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentPage = 3;
                          currentScreen = Restaurants();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            BrselApp.restaurantsicon,
                            size: 20,
                            color:
                                currentPage == 3 ? myPrimaryColor : myGreyColor,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'المطاعم',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: currentPage == 3
                                    ? myPrimaryColor
                                    : myGreyColor),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 70,
                      onPressed: () {
                        setState(() {
                          currentPage = 4;
                          currentScreen = Settings();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            BrselApp.settingsicon,
                            size: 20,
                            color:
                                currentPage == 4 ? myPrimaryColor : myGreyColor,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'اعدادات',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: currentPage == 4
                                    ? myPrimaryColor
                                    : myGreyColor),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
