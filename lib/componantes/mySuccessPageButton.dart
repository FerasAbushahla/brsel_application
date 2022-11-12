import 'package:brsel_application/constants.dart';
import 'package:flutter/material.dart';

class MySuccessPageButton extends StatelessWidget {
  final String title;
  final bool? loading;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final Color? circularProgressColor;
  const MySuccessPageButton({
    Key? key,
    required this.title,
    this.loading,
    required this.color,
    required this.textColor,
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
              style: TextStyle(
                fontSize: 13,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
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
        padding: EdgeInsets.symmetric(vertical: 20),
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
