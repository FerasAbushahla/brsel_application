import 'package:brsel_application/componantes/myCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyHomeCustomAppBar(),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: SizeConfig.screenWidth,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 9, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'العروض(130)',
                          style: MyCustomTextStyle.myH2,
                        ),
                        Text(
                          'تصفح الكل',
                          style: MyCustomTextStyle.myGreenTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Image.asset(
                        'assets/images/Ad.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المطاعم المتوفرة(120)',
                    style: MyCustomTextStyle.myH2,
                  ),
                  Text(
                    'تصفح الكل',
                    style: MyCustomTextStyle.myGreenTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  AvailableRestList.length,
                  (index) => Padding(
                    padding: index == 0
                        ? EdgeInsets.only(right: 20)
                        : EdgeInsets.only(right: 10),
                    child: availableRestautantsCard(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'وجبات رائجة',
                    style: MyCustomTextStyle.myH2,
                  ),
                  Text(
                    'مشاهدة الكل',
                    style: MyCustomTextStyle.myGreenTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  AvailableRestList.length,
                  (index) => Padding(
                    padding: index == 0
                        ? EdgeInsets.only(right: 20)
                        : EdgeInsets.only(right: 10),
                    child: featuredMealsCard(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container availableRestautantsCard() {
    return Container(
      width: 76,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: 76,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.asset(
              'assets/images/Restaurant img.jpg',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'كنتاكي',
            style: MyCustomTextStyle.myCardTitleBlackSecondTextStyle,
          )
        ],
      ),
    );
  }

  Container featuredMealsCard() {
    return Container(
      width: 57,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Burger.png',
            fit: BoxFit.contain,
            width: 50,
            height: 45,
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            'تاكو',
            style: MyCustomTextStyle.myCardSecondTitleBlackSecondTextStyle,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            '(13)',
            style: MyCustomTextStyle.myH1withOpacityTextStyle,
          ),
          Text(
            'مطعم',
            style: MyCustomTextStyle.myH1withOpacityTextStyle,
          ),
        ],
      ),
    );
  }
}
