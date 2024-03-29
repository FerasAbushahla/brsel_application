import 'package:flutter/material.dart';

const MaterialColor myMaterialPrimaryColor = const MaterialColor(
  0xFF31C46C,
  const <int, Color>{
    50: Color.fromRGBO(49, 196, 108, .1),
    100: Color.fromRGBO(49, 196, 108, .2),
    200: Color.fromRGBO(49, 196, 108, .3),
    300: Color.fromRGBO(49, 196, 108, .4),
    400: Color.fromRGBO(49, 196, 108, .5),
    500: Color.fromRGBO(49, 196, 108, .6),
    600: Color.fromRGBO(49, 196, 108, .7),
    700: Color.fromRGBO(49, 196, 108, .8),
    800: Color.fromRGBO(49, 196, 108, .9),
    900: Color.fromRGBO(49, 196, 108, 10),
  },
);

const myBackgroundColor = Color(0xFFF9F9F9);
const myPrimaryColor = Color(0xFF31C46C);
const myBackgroundFillingColor = Color(0xFFF9F9F9);
const myBlackColor = Color(0xFF000000);
const myBlackSecondColor = Color(0xFF01000D);
const myTextGreyColor = Color(0xFF9E9E9E);
const myDarkGreyColor = Color(0xFF595959);
const myBorderGreyColor = Color(0xFFE8E8E8);
const myGreyColor = Color(0xFFA1A1A1);
const mySecGreyColor = Color(0xFF8F92A1);
const myThirdGreyColor = Color(0xFF707070);
const myYellowColor = Color(0xFFFFDE0A);
const mySecondaryColor = Color(0xFF275D89);
const myDarkBlueColor = Color(0xFF3E4958);
const mylighterDarkBlueColor = Color(0xFF111934);
const myRedColor = Color(0xFFE35757);
const mySecRedColor = Color(0xFFF94450);
const mySecAppBarTitle = Color(0xFF3E4958);
const myDarkBlue = Color(0xFF05172B);
const myBlackHalfOpacity = Color(0xFF141212);

class BrselApp {
  BrselApp._();

  static const _kFontFam = 'BrselApp';
  static const String? _kFontPkg = null;

  static const IconData logouticon =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData notificationsicon =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData ordersicon =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData paymenticon =
      IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData plusicon =
      IconData(0xe807, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData profile =
      IconData(0xe809, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData restaurantsicon =
      IconData(0xe80a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData reviewedicon =
      IconData(0xe80b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData searchicon =
      IconData(0xe80c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData settingsicon =
      IconData(0xe80d, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData staricon =
      IconData(0xe80e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData supporticon =
      IconData(0xe80f, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData viewicon =
      IconData(0xe810, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData visiblityicon =
      IconData(0xe811, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData arrowdownicon =
      IconData(0xe812, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData arrowsicon =
      IconData(0xe813, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData attachicon =
      IconData(0xe814, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData cancelcircleicon =
      IconData(0xe815, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData checkicon =
      IconData(0xe817, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData couponicon =
      IconData(0xe81a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData deliveryicon =
      IconData(0xe81b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData deliverysecicon =
      IconData(0xe81c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData editicon =
      IconData(0xe81e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData erroricon =
      IconData(0xe820, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData filtericon =
      IconData(0xe821, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData hearticon =
      IconData(0xe822, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData homesecicon =
      IconData(0xe825, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData infoicon =
      IconData(0xe826, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData locationsecicon =
      IconData(0xe828, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData lockicon =
      IconData(0xe829, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class MyCustomTextStyle {
  static const TextStyle myTitleTextStyle = TextStyle(
    fontSize: 22,
    color: myBlackColor,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle myH1TextStyle = TextStyle(
    fontSize: 12,
    color: myBlackColor,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle myH2TextStyle = TextStyle(
    fontSize: 12,
    color: myBlackColor,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle myRedH1TextStyle = TextStyle(
    decoration: TextDecoration.lineThrough,
    fontSize: 12,
    color: myRedColor,
    fontWeight: FontWeight.w300,
  );
  static TextStyle myH1withOpacityTextStyle = TextStyle(
    fontSize: 12,
    color: myBlackColor.withOpacity(0.5),
    fontWeight: FontWeight.w300,
  );
  static TextStyle myH2 = TextStyle(
    fontSize: 12,
    color: myDarkGreyColor,
    fontWeight: FontWeight.w500,
  );
  static TextStyle myDriverDteTextStyle = TextStyle(
    fontSize: 12,
    color: myBlackColor.withOpacity(0.4),
    fontWeight: FontWeight.w500,
  );
  static TextStyle myH22 = TextStyle(
    fontSize: 12,
    color: myGreyColor,
    fontWeight: FontWeight.w500,
  );
  static TextStyle myH3 = TextStyle(
    fontSize: 12,
    color: myDarkGreyColor,
    fontWeight: FontWeight.w700,
  );
  static TextStyle myP1 = TextStyle(
    fontSize: 10,
    color: myBlackColor,
    fontWeight: FontWeight.w300,
  );
  static TextStyle myP1WithOpacity = TextStyle(
    fontSize: 10,
    color: myBlackColor.withOpacity(0.5),
    fontWeight: FontWeight.w300,
  );
  static TextStyle myCounter = TextStyle(
    fontSize: 10,
    color: Colors.white,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle mySearchHintTextStyle = TextStyle(
    fontSize: 14,
    color: myTextGreyColor,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle myDriverAppBarSecTextStyle = TextStyle(
    fontSize: 14,
    color: myGreyColor,
    fontWeight: FontWeight.w500,
  );
  static TextStyle myHintTextStyle = TextStyle(
    fontSize: 12,
    color: myTextGreyColor,
    fontWeight: FontWeight.w400,
  );
  static TextStyle myOrderDetailsH1 = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle myTextFieldTitletextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: mySecGreyColor,
  );

  static const TextStyle myTitletextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: myDarkBlueColor,
  );
  static const TextStyle myDriverTitletextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static const TextStyle myTitleSecTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: myBlackColor,
  );
  static const TextStyle myBigtextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: myDarkBlueColor,
  );
  static const TextStyle myCardTitletextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: myBlackColor,
  );
  static TextStyle myCardtextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: myBlackColor.withOpacity(0.5),
  );
  static const TextStyle myNormaltextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: myDarkBlueColor,
  );
  static const TextStyle myGreenTextStyle = TextStyle(
    fontSize: 9,
    color: myPrimaryColor,
    fontWeight: FontWeight.w700,
  );
  static TextStyle myDetailsTextStyle = TextStyle(
    fontSize: 9,
    color: myBlackColor.withOpacity(0.5),
    fontWeight: FontWeight.w300,
  );
  static TextStyle myDetailsSecTextStyle = TextStyle(
    fontSize: 8,
    color: myBlackColor.withOpacity(0.5),
    fontWeight: FontWeight.w500,
  );
  static TextStyle myDetailsThirdTextStyle = TextStyle(
    fontSize: 10,
    color: myBlackColor,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle myCardTitleBlackSecondTextStyle = TextStyle(
    fontSize: 12,
    color: myBlackSecondColor,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle myCardSecondTitleBlackSecondTextStyle = TextStyle(
    fontSize: 11,
    color: myBlackSecondColor,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle myCardSecondTitleBlackClickedSecondTextStyle =
      TextStyle(
    fontSize: 11,
    color: Colors.white,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle myLoginForgetPasswordTextStyle = TextStyle(
    fontSize: 11,
    color: myBlackColor,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle myButtonTextStyle = TextStyle(
    fontSize: 13,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle myTextButtonTextStyle = TextStyle(
    fontSize: 13,
    color: myBlackColor,
    fontWeight: FontWeight.w500,
  );
  static TextStyle myTextButtonTextStyleWithOpacity = TextStyle(
    fontSize: 13,
    color: myBlackColor.withOpacity(0.7),
    fontWeight: FontWeight.w500,
  );
  static const TextStyle myTextButtonLightTextStyle = TextStyle(
    fontSize: 13,
    color: myBlackColor,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle myTabBarSelectedLabelTextStyle = TextStyle(
    fontFamily: "ArbFONTS-Montserrat-Arabic",
    fontSize: 13,
    color: myBlackColor,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle myTabBarUnSelectedLabelTextStyle = TextStyle(
    fontFamily: "ArbFONTS-Montserrat-Arabic",
    fontSize: 13,
    color: myGreyColor,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle myAppBarTitleTextStyle = TextStyle(
    fontSize: 13,
    color: myBlackColor,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle mySettingsTitleTextStyle = TextStyle(
    fontSize: 13,
    color: mylighterDarkBlueColor,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle myAppBarSecTitleTextStyle = TextStyle(
    fontSize: 15,
    color: mySecAppBarTitle,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle myOnBoardingTextButtonTextStyle = TextStyle(
    fontSize: 16,
    color: myTextGreyColor,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle myOnBoardingTitleTextStyle = TextStyle(
    fontSize: 16,
    color: myDarkBlueColor,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle myDriverAppBarTitleTextStyle = TextStyle(
    fontSize: 16,
    color: mylighterDarkBlueColor,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle mySuccessPageTitleTextStyle = TextStyle(
    fontSize: 18,
    color: myDarkBlue,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle mySuccessPageTextStyle = TextStyle(
    fontSize: 14,
    color: myDarkBlue,
    fontWeight: FontWeight.w500,
  );
  static TextStyle myOnBoardingTextStyle = TextStyle(
    height: 1.7,
    fontSize: 14,
    color: mylighterDarkBlueColor.withOpacity(0.5),
    fontWeight: FontWeight.w300,
  );
  static TextStyle myDriverStatTextStyle = TextStyle(
    fontSize: 14,
    color: myBlackColor.withOpacity(0.5),
    fontWeight: FontWeight.w300,
  );
}

InputDecoration searchInputDecoration(
    {Widget? prefix, String? hint, Widget? suffix}) {
  return InputDecoration(
    fillColor: myBackgroundColor,
    filled: true,
    hintStyle: MyCustomTextStyle.myHintTextStyle,
    hintText: hint,
    suffixIcon: suffix,
    prefixIcon: Container(child: prefix),
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        width: 1.0,
        color: myBorderGreyColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        width: 1.0,
        color: myBorderGreyColor,
      ),
    ),
  );
}

InputDecoration myInputDecoration(
    {Widget? prefix, String? hint, Widget? suffix}) {
  return InputDecoration(
    counterText: "",
    fillColor: myBackgroundFillingColor,
    filled: true,
    hintStyle: MyCustomTextStyle.myHintTextStyle,
    hintText: hint,
    suffixIcon: suffix,
    prefixIcon: prefix,
    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        width: 1.0,
        color: myBackgroundFillingColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        width: 1.0,
        color: myBackgroundFillingColor,
      ),
    ),
    // disabledBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(8.0),
    //   borderSide: BorderSide(
    //     width: 1.0,
    //     color: myBorderColor,
    //   ),
    // ),
    // errorBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(30.0),
    //   borderSide: BorderSide(
    //     color: Colors.red,
    //     width: 1.0,
    //   ),
    // ),
    // focusedErrorBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(30.0),
    //   borderSide: BorderSide(
    //     color: Colors.red,
    //     width: 1.0,
    //   ),
    // ),
    // focusedBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(30.0),
    //   borderSide: BorderSide(width: 1.0, color: myPrimaryColor),
    // ),
  );
}

const AvailableRestList = [
  {
    'imagePath': 'assets/images/Dogs.jpg',
    'title': 'Dogs',
  },
  {
    'imagePath': 'assets/images/SmallPet.jpg',
    'title': 'Small pet',
  },
  {
    'imagePath': 'assets/images/Fish.jpg',
    'title': 'Fish',
  },
  {
    'imagePath': 'assets/images/Bird.jpg',
    'title': 'Bird',
  },
  {
    'imagePath': 'assets/images/Cats.jpg',
    'title': 'Cats',
  },
  {
    'imagePath': 'assets/images/Reptiles.jpg',
    'title': 'Reptiles',
  },
  {
    'imagePath': 'assets/images/Horses.jpg',
    'title': 'Horses',
  },
  {
    'imagePath': 'assets/images/FarmAnimal.jpg',
    'title': 'Farm animal',
  },
];
const mealsBurgerList = [
  {
    'imagePath': 'assets/images/Burger.jpg',
    'title': 'برجر',
  },
  {
    'imagePath': 'assets/images/Burger.jpg',
    'title': 'برجر',
  },
  {
    'imagePath': 'assets/images/Burger.jpg',
    'title': 'برجر',
  },
  {
    'imagePath': 'assets/images/Burger.jpg',
    'title': 'برجر',
  },
  {
    'imagePath': 'assets/images/Burger.jpg',
    'title': 'برجر',
  },
  {
    'imagePath': 'assets/images/Burger.jpg',
    'title': 'برجر',
  },
  {
    'imagePath': 'assets/images/Burger.jpg',
    'title': 'برجر',
  },
];
const RestaurantesCategoriesList = [
  {
    'title': 'مضاف حديثا',
  },
  {
    'title': 'برجر',
  },
  {
    'title': 'مشروبات',
  },
  {
    'title': 'دجاج',
  },
  {
    'title': 'معجنات',
  },
  {
    'title': 'مشروبات',
  },
];
