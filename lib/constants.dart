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
  static const TextStyle myHintTextStyle = TextStyle(
    fontSize: 14,
    color: myTextGreyColor,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle myGreenTextStyle = TextStyle(
    fontSize: 9,
    color: myPrimaryColor,
    fontWeight: FontWeight.w700,
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
}

InputDecoration searchInputDecoration(
    {Widget? prefix, String? hint, Widget? suffix}) {
  return InputDecoration(
    fillColor: myBackgroundFillingColor,
    filled: true,
    hintStyle: MyCustomTextStyle.myHintTextStyle,
    hintText: hint,
    suffixIcon: suffix,
    prefixIcon: Container(height: 24, child: prefix),
    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 0),
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
