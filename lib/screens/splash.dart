import 'package:brsel_application/screens/login.dart';
import 'package:brsel_application/screens/register.dart';
import 'package:brsel_application/size_config.dart';
import 'package:brsel_application/wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      token = preferences.getString('token');
      if (token == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => Login())));
      } else if (token != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => Wraper())));
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
