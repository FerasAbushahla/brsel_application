import 'package:brsel_application/screens/login.dart';
import 'package:brsel_application/screens/onBoarding/onBoarding.dart';
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
      token = preferences.getString('token');
      if (firstTime == null) {
        Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => OnBoarding())))
            .then((value) {
          preferences.setBool('firstTime', true);
        });
      } else if (token == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => Login())));
      } else if (token != null) {
        if (userPersonalInfoDone != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => Wraper())));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => PersonalInfo())));
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
