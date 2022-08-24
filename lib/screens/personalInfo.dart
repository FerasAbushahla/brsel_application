import 'package:brsel_application/componantes/myCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PersomalInfo extends StatefulWidget {
  const PersomalInfo({Key? key}) : super(key: key);

  @override
  State<PersomalInfo> createState() => _PersomalInfoState();
}

class _PersomalInfoState extends State<PersomalInfo> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: MyCustomAppBar(
        leading: MyIconButton(),
      ),
    );
  }
}
