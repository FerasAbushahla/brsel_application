import 'package:brsel_application/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final bool? loading;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? circularProgressColor;
  const MyButton({
    Key? key,
    required this.title,
    this.loading,
    required this.color,
    this.onPressed,
    this.circularProgressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: loading == false
          ? Text(
              title,
              style: MyCustomTextStyle.myButtonTextStyle,
            )
          : SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                color: circularProgressColor,
                strokeWidth: 3,
              ),
            ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14),
        elevation: 0,
        backgroundColor: color,
        // primary: mySecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
