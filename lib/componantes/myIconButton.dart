import 'package:brsel_application/constants.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String? imagePath;

  const MyIconButton({Key? key, this.onPress, this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: myBackgroundFillingColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: myBorderGreyColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(imagePath!),
        ),
      ),
    );
  }
}
