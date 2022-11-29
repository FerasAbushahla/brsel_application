import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/mySettingsSecCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsAndPolicies extends StatefulWidget {
  const TermsAndPolicies({super.key});

  @override
  State<TermsAndPolicies> createState() => _TermsAndPoliciesState();
}

class _TermsAndPoliciesState extends State<TermsAndPolicies> {
  // bool? switchValue;
  // bool switchValue = false;
  bool value = false;
  bool switchSelect = false;
  bool loading = false;

  // Future getSharedPrefs() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.getBool('acceptPolicies');
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSwitchValues();
  }

  getSwitchValues() async {
    switchSelect = await getSwitchState();
    setState(() {});
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("acceptPolicies", value);
    print('Switch Value saved $value');
    return prefs.setBool("acceptPolicies", value);
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool switchSelect = prefs.getBool("acceptPolicies") ?? false;
    print(switchSelect);

    return switchSelect;
  }

  // Future getValueFlag() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     switchSelect = preferences.getBool('acceptPolicies') ?? true;
  //   });
  // }

  // Future setValueFlag(bool switchValue) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setBool('acceptPolicies', switchValue);
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            MySettingsSecCustomAppBar(
              title: 'الشروط والأحكام',
              leading: MyIconButton(
                onPress: () {
                  // Get.back();
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'الشروط',
                              style: MyCustomTextStyle.mySettingsTitleTextStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل ',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: mySecGreyColor,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5),
                              // style: MyCustomTextStyle.myH1withOpacityTextStyle,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'الأحكام',
                              style: MyCustomTextStyle.mySettingsTitleTextStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف. خمسة قرون من الزمن لم تقضي على هذا النص، بل انه حتى صار مستخدماً وبشكله الأصلي في الطباعة والتنضيد الإلكتروني. انتشر بشكل كبير في ستينيّات هذا القرن مع إصدار رقائق "ليتراسيت" (Letraset) البلاستيكية تحوي مقاطع من هذا النص، وعاد لينتشر مرة أخرى مؤخراَ مع ظهور برامج النشر الإلكتروني مثل "ألدوس بايج مايكر" (Aldus PageMaker) والتي حوت أيضاً على نسخ من نص لوريم إيبسوم.',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: mySecGreyColor,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'قرأت الشروط والأحكام كاملة',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: mylighterDarkBlueColor,
                                      fontWeight: FontWeight.w300),
                                ),
                                Switch(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  inactiveThumbColor: myGreyColor,
                                  inactiveTrackColor:
                                      myGreyColor.withOpacity(0.2),
                                  value: switchSelect,
                                  onChanged: (bool value) {
                                    setState(() {
                                      switchSelect = value;
                                      // saveSwitchState(value);
                                      print('Saved state is $switchSelect');
                                      //switch works
                                    });
                                    print(switchSelect);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            MyButton(
                              loading: loading,
                              title: 'حفظ ومتابعة',
                              color: mySecondaryColor,
                              onPressed: () {
                                saveSwitchState(switchSelect);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
