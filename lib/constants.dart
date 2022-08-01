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

const myBackgroundColor = Color(0xFFFFFFFF);
const myPrimaryColor = Color(0xFF31C46C);
const myBackgroundFillingColor = Color(0xFFF9F9F9);
const myBlackColor = Color(0xFF000000);
const myTextGreyColor = Color(0xFF9E9E9E);
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
  static const TextStyle myHintTextStyle = TextStyle(
    fontSize: 14,
    color: myTextGreyColor,
    fontWeight: FontWeight.w400,
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
    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 12),
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
