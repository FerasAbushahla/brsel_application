import 'package:brsel_application/screens/location.dart';
import 'package:brsel_application/screens/login.dart';
import 'package:brsel_application/screens/onBoarding.dart';
import 'package:brsel_application/screens/personalImage.dart';
import 'package:brsel_application/screens/personalInfo.dart';
import 'package:brsel_application/size_config.dart';
import 'package:brsel_application/wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? token;
  bool? firstTime;
  bool? userPersonalInfoDone;
  String? userFirstName;
  String? userPesonalImage;
  // bool? _isFirstRun;
  // bool? _isFirstCall;

  // void setWelcomeSharedPreference({String? key, bool? value}) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   firstTime = await preferences.setBool(key!, value!);
  // }

  // void _checkFirstRun() async {
  //   bool ifr = await IsFirstRun.isFirstRun();
  //   setState(() {
  //     _isFirstRun = ifr;
  //   });
  // }

  // void _checkFirstCall() async {
  //   bool ifc = await IsFirstRun.isFirstCall();
  //   setState(() {
  //     _isFirstCall = ifc;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), () async {
      // _checkFirstRun();
      // _checkFirstCall();
      // print('_isFirstRun $_isFirstRun');
      // print('_isFirstCall $_isFirstCall');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // firstTime = await preferences.setBool('firstTime', firstTime);
      firstTime = preferences.getBool('firstTime');
      userPersonalInfoDone = preferences.getBool('userPersonalInfoDone');
      print('userPersonalInfoDone...$userPersonalInfoDone');
      token = preferences.getString('token');
      userFirstName = preferences.getString('firstName');
      userPesonalImage = preferences.getString('personalImage');
      if (firstTime == null) {
        Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => OnBoarding())))
            .then((value) {
          preferences.setBool('firstTime', true);
        });
      } else if (token == null) {
        print('token == null');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => Login())));
      } else if (token != null) {
        print('token != null');
        if (userPersonalInfoDone != false) {
          print('userPersonalInfoDone != false');

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => Wraper())));
        } else {
          if (userFirstName == null) {
            print('userFirstName == null');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => PersonalInfo(
                          fromSettings: false,
                        ))));
          } else if (userPesonalImage == null) {
            print('userPesonalImage == null');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => PersonalImage(
                          fromSettings: false,
                        ))));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => Location(
                          fromSettings: false,
                        ))));
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
          child: SvgPicture.asset(
        'assets/images/splash.svg',
        height: SizeConfig.screenHeight,
        fit: BoxFit.cover,
      )),
    );
  }
}
