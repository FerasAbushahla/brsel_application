import 'package:brsel_application/screens/Driver/driverHome.dart';
import 'package:brsel_application/screens/Driver/driverPersonalInfo.dart';
import 'package:brsel_application/screens/location.dart';
import 'package:brsel_application/screens/orderDetails.dart';
import 'package:brsel_application/screens/orderSuccess.dart';
import 'package:brsel_application/screens/payment.dart';
import 'package:brsel_application/screens/splash.dart';
import 'package:brsel_application/service/hiveDB.dart';
import 'package:brsel_application/wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleDBHelper.dbHelper.initDB();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BrselApp',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar"),
      ],
      locale: const Locale("ar"),
      theme: ThemeData(
        fontFamily: "ArbFONTS-Montserrat-Arabic",
        scaffoldBackgroundColor: myBackgroundColor,
        primarySwatch: myMaterialPrimaryColor,
      ),
      home: DriverHome(),
    );
  }
}
