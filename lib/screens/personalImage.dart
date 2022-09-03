import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/componantes/myCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../componantes/myIconButton.dart';

class PersonalImage extends StatefulWidget {
  const PersonalImage({Key? key}) : super(key: key);

  @override
  State<PersonalImage> createState() => _PersonalImageState();
}

class _PersonalImageState extends State<PersonalImage> {
  void initState() {
    Future.delayed(const Duration(milliseconds: 5), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      print(preferences.get('firstName'));
      print(preferences.get('lastName'));
      print(preferences.get('phoneNumber'));
      print(preferences.get('sex'));
      // userBox = Hive.box('user');
      // var myUser = await userBox.getAt(0);
      // print(myUser);
    });
    super.initState();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: MyCustomAppBar(
        leading: Column(
          children: [
            SizedBox(
              height: 11,
            ),
            MyIconButton(
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 125),
              child: Text(
                'الصورة الشخصية',
                textAlign: TextAlign.center,
                style: MyCustomTextStyle.myTitletextStyle,
              ),
            ),
            SizedBox(
              height: 13,
            ),
            SvgPicture.asset('assets/images/PersonalInfoProgress2.svg',
                height: getProportionalScreenHeight(24)),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Text(
                'سيتم عرض هذه البيانات في ملف تعريف حسابك للأمان',
                textAlign: TextAlign.center,
                style: MyCustomTextStyle.myBigtextStyle,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: myPrimaryColor.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Image.asset('assets/images/Gallery.png'),
                            )
                            // SvgPicture.asset(
                            //   'assets/images/Gallery.svg',
                            //   color: myPrimaryColor,
                            //   height: getProportionalScreenHeight(60),
                            // ),
                            ),
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          'التقط صورة',
                          style: MyCustomTextStyle.myNormaltextStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: myPrimaryColor.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Image.asset('assets/images/Gallery.png'),
                            )
                            // SvgPicture.asset(
                            //   'assets/images/Gallery.svg',
                            //   color: myPrimaryColor,
                            //   height: getProportionalScreenHeight(60),
                            // ),
                            ),
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          'اختيار من الاستيديو',
                          style: MyCustomTextStyle.myNormaltextStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 110,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: MyButton(
                loading: loading,
                title: 'حفظ ومتابعة',
                onPressed: () async {},
              ),
            )
          ],
        )),
      ),
    );
  }
}
