import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/myOrdersCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyOrdersCustomAppBar(
              title: 'المطاعم',
              leading: MyIconButton(
                onPress: () {
                  Navigator.pop(context);
                },
                borderRadius: 12,
                BackgroundColor: Colors.white,
                iconWidget: Padding(
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    'assets/images/ArrowBack Icon.svg',
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: index == 0
                          ? EdgeInsets.only(bottom: 6)
                          : EdgeInsets.symmetric(vertical: 6),
                      child: orderCard(),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container orderCard() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl:
                    // homeResturante.image ??
                    'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                imageBuilder: (context, imageProvider) => Container(
                  width: 95,
                  height: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
                placeholder: (context, url) =>
                    Center(child: const CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  height: 76,
                  child: const Icon(
                    Icons.broken_image,
                    color: myGreyColor,
                    size: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        'وجبة برجر',
                        style: MyCustomTextStyle.myCardTitletextStyle,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            '15 ر.ع',
                            style: MyCustomTextStyle.myTextButtonTextStyle,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 22,
                            width: 60,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1.5,
                                    blurRadius: 1.5,
                                    offset: Offset(0, 1),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: IconButton(
                                    padding: EdgeInsets.all(5),
                                    icon: Icon(
                                      Icons.add,
                                      size: 11.7,
                                      color: myPrimaryColor,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: myPrimaryColor),
                                    child: Center(
                                        child: Text(
                                      '1',
                                      style: MyCustomTextStyle.myCounter,
                                    )),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    padding: EdgeInsets.all(5),
                                    icon: Icon(
                                      Icons.remove,
                                      size: 11.7,
                                      color: myPrimaryColor,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف.',
                    maxLines: 2,
                    style: MyCustomTextStyle.myH1withOpacityTextStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
