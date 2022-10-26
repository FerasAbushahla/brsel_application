import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/mySettingsSecCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class TermsAndPolicies extends StatefulWidget {
  const TermsAndPolicies({super.key});

  @override
  State<TermsAndPolicies> createState() => _TermsAndPoliciesState();
}

class _TermsAndPoliciesState extends State<TermsAndPolicies> {
  bool switchValue = false;
  bool loading = false;
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
                                  value: switchValue,
                                  onChanged: (val) {
                                    setState(() {
                                      switchValue = val;
                                    });
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
                              onPressed: () {},
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
