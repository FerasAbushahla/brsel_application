import 'dart:convert';

import 'package:brsel_application/constants.dart';
import 'package:brsel_application/screens/home.dart';
import 'package:brsel_application/screens/meals.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ZoomDrawerController z = ZoomDrawerController();

class HomeZoomDrawer extends StatefulWidget {
  const HomeZoomDrawer({Key? key}) : super(key: key);

  @override
  State<HomeZoomDrawer> createState() => _HomeZoomDrawerState();
}

class _HomeZoomDrawerState extends State<HomeZoomDrawer> {
  String firstName = '';
  String lastName = '';
  String personalImage = '';

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    setState(() {
      firstName = preferences.getString("firstName") ?? '';
      print(firstName);
      lastName = preferences.getString("lastName") ?? '';
      print(lastName);
      personalImage = preferences.getString("personalImage") ?? '';
      print(personalImage);
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
        personalImage: personalImage,
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String personalImage;
  const DrawerMenu(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.personalImage})
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Image.memory(
                      base64Decode(personalImage),
                      fit: BoxFit.cover,
                    ),
                    // child: Image.asset(
                    //   'assets/images/Profile.jpg',
                    //   fit: BoxFit.cover,
                    // ),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Meals(
                                focus: false,
                              )));
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
