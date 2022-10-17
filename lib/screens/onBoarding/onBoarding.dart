import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int current = 0;
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    bool loading = false;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 65,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) => buildStep(index)),
            ),
          ),
          Container(
            height: SizeConfig.screenHeight - getProportionalScreenHeight(65),
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  current = value;
                });
              },
              controller: controller,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    SvgPicture.asset(
                      'assets/images/firstOnBoarding.svg',
                      height: 215,
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      'سهولة الطلب',
                      style: MyCustomTextStyle.myOnBoardingTitleTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        textAlign: TextAlign.center,
                        'هدفنا هو جعل حياتك أسهل من خلال تقديم خدمة توصيل سريعة وموثوقة وبأسعار تنافسية. نحن نبحث دائمًا عن طرق جديدة لتحسين خدماتنا وتطبيقنا حتى نتمكن من تقديم أفضل تجربة ممكنة لعملائنا.',
                        style: MyCustomTextStyle.myOnBoardingTextStyle,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: OnboardingButtonsBar(skipOneStep: () {
                        controller.nextPage(
                            duration: kThemeAnimationDuration,
                            curve: Curves.easeOut);
                      }, skip: () {
                        controller.jumpToPage(4);
                      }),
                    ),
                    SizedBox(
                      height: 52,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    SvgPicture.asset(
                      'assets/images/secondOnBoarding.svg',
                      height: 215,
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      'التوصيل خلال دقائق',
                      style: MyCustomTextStyle.myOnBoardingTitleTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        textAlign: TextAlign.center,
                        'يسرنا أن نقدم بارسل، التطبيق الأول من نوعه في سلطنة عمان الذي يوفر توصيل سريع للطلبات وبأسعار تنافسية نحن فريق من الأصدقاء المتحمسين لجعل الحياة أسهل لعملائنا ونحن في مهمة لتقديم أفضل خدمة ممكنة.',
                        style: MyCustomTextStyle.myOnBoardingTextStyle,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: OnboardingButtonsBar(skipOneStep: () {
                        controller.nextPage(
                            duration: kThemeAnimationDuration,
                            curve: Curves.easeOut);
                      }, skip: () {
                        controller.jumpToPage(4);
                      }),
                    ),
                    SizedBox(
                      height: 52,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    SvgPicture.asset(
                      'assets/images/thirdOnBoarding.svg',
                      height: 215,
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      'سهولة ومرونة الإستخدام',
                      style: MyCustomTextStyle.myOnBoardingTitleTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        textAlign: TextAlign.center,
                        'إنه الحل الأمثل عندما تشعر بالجوع وليس لديك وقت للطهي. مع بارسل، يمكنك طلب طعامك ببضع نقرات وتوصيله إلى باب منزلك ساخنًا وطازجًا.',
                        style: MyCustomTextStyle.myOnBoardingTextStyle,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: OnboardingButtonsBar(skipOneStep: () {
                        controller.nextPage(
                            duration: kThemeAnimationDuration,
                            curve: Curves.easeOut);
                      }, skip: () {
                        controller.jumpToPage(4);
                      }),
                    ),
                    SizedBox(
                      height: 52,
                    )
                  ],
                ),
                Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.antiAlias,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        SvgPicture.asset(
                          'assets/images/Logo.svg',
                          height: 85,
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text(
                            "مرحبا بك",
                            style: TextStyle(
                                color: myPrimaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "نحن شركة شابة وطموحة تتطلع إلى إحداث فرق في صناعة توصيل الطعام. يقع مقرنا في سلطنة عمان ونقدم خدماتنا لكل من الشركات والمستهلكين. نحن نسعى باستمرار لتحسين خدماتنا وتقديم أفضل تجربة ممكنة لعملائنا.",
                            style: MyCustomTextStyle.myOnBoardingTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: MyButton(
                            title: 'اطلب أول وجبة من بارسل',
                            color: myPrimaryColor,
                            loading: loading,
                            onPressed: () {},
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: OnboardingButtonsBar(skipOneStep: () {
                        //     controller.nextPage(
                        //         duration: kThemeAnimationDuration,
                        //         curve: Curves.easeOut);
                        //   }, skip: () {
                        //     controller.jumpToPage(4);
                        //   }),
                        // ),
                        // SizedBox(
                        //   height: 52,
                        // )
                      ],
                    ),
                    Positioned(
                      bottom: -36,
                      child: Align(
                        alignment: FractionalOffset.bottomRight,
                        child: SvgPicture.asset(
                          'assets/images/fourthOnBoarding.svg',
                          height: 300,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildStep(int index) {
    return AnimatedContainer(
        duration: kThemeAnimationDuration,
        margin: EdgeInsets.only(
          // top: getProportionalScreenHeight(0),
          left: getProportionalScreenWidth(8),
        ),
        width: 75,
        height: 2,
        decoration: BoxDecoration(
          color: current == index
              ? myPrimaryColor
              : myPrimaryColor.withOpacity(0.3),
          // borderRadius: BorderRadius.circular(8),
        ));
  }

  Widget OnboardingButtonsBar({VoidCallback? skipOneStep, VoidCallback? skip}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RawMaterialButton(
          onPressed: skipOneStep,
          fillColor: myPrimaryColor,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20.0,
          ),
          padding: EdgeInsets.fromLTRB(5, 15, 15, 15),
          shape: CircleBorder(),
        ),
        Spacer(),
        TextButton(
          onPressed: skip,
          child: Text(
            'تخطي',
            style: MyCustomTextStyle.myOnBoardingTextButtonTextStyle,
          ),
        ),
      ],
    );
  }
}
