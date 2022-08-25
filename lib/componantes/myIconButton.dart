import 'package:brsel_application/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyIconButton extends StatelessWidget {
  final VoidCallback? onPress;
  final Widget? iconWidget;
  final double? borderRadius;
  final Color? BackgroundColor;

  const MyIconButton(
      {Key? key,
      this.onPress,
      this.iconWidget,
      this.borderRadius,
      this.BackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: BackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius!),
          border: Border.all(color: myBorderGreyColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: iconWidget,
        ),
      ),
    );
  }
}
