import 'package:brsel_application/constants.dart';
import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Widget? leading;
  const MyCustomAppBar({Key? key, this.leading})
      : preferredSize = const Size.fromHeight(56),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: myBackgroundColor,
      elevation: 0,
      leading: leading,
    );
  }
}
