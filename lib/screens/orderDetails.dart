import 'dart:async';
import 'package:brsel_application/componantes/myOrderDetailsCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String? userLat;
  String? userLong;
  String? accessToken;

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition muscatPosition =
      CameraPosition(target: LatLng(23.5880, 58.3829), zoom: 12);
  Set<Marker> markers = {};

  Future getSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userLat = sharedPreferences.getString('currentPositionLatitude');
      userLong = sharedPreferences.getString('currentPositionLongitude');

      accessToken = sharedPreferences.getString('token');
    });

    print('userLat $userLat');
    print('userLong $userLong');
    print('accessToken $accessToken');
  }

  Future displaySavedLocation() async {
    try {
      await getSharedPreferences();
      print('userLonggg  $userLong');
      print('userLattt  $userLat');
      print('userLonggg double  ${double.parse(userLong!)}');

      double doubleLat = double.parse(userLat!);
      double doubleLong = double.parse(userLong!);
      final GoogleMapController controller = await _controller.future;

      controller.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(doubleLat, doubleLong), zoom: 12)));

      markers.clear();
      markers.add(Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(double.parse(userLat!), double.parse(userLong!))));

      List<Placemark> placemark = await placemarkFromCoordinates(
          double.parse(userLat!), double.parse(userLong!),
          localeIdentifier: "ar");
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displaySavedLocation();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            MyOrderDetailsCustomAppBar(
              title: 'تتبع الطلب',
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          // height: 350,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: muscatPosition,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                              // googleMapController = controller;
                            },
                            markers: markers,
                            zoomControlsEnabled: false,
                          ),
                        ),
                      ),
                      Expanded(flex: 4, child: SizedBox())
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(flex: 3, child: SizedBox()),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    height: 14,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(34),
                                          topRight: Radius.circular(34),
                                        ),
                                        color: Colors.white,
                                      ),
                                      // height: 420,
                                      width: SizeConfig.screenWidth,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/CircleChecked.svg',
                                              ),
                                              SizedBox(
                                                width: 11,
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/dashedLineHorizontal.svg',
                                              ),
                                              SizedBox(
                                                width: 11,
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/CircleChecked.svg',
                                              ),
                                              SizedBox(
                                                width: 11,
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/dashedLineHorizontal.svg',
                                              ),
                                              SizedBox(
                                                width: 11,
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/CircleChecked.svg',
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 55,
                                                child: Text(
                                                  'تم استلام طلبكم',
                                                  style: MyCustomTextStyle
                                                      .myTextButtonLightTextStyle,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Container(
                                                width: 80,
                                                child: Text(
                                                  'الطلب بالطريق',
                                                  style: MyCustomTextStyle
                                                      .myTextButtonLightTextStyle,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Container(
                                                width: 55,
                                                child: Text(
                                                  'تم استلام طلبكم',
                                                  style: MyCustomTextStyle
                                                      .myTextButtonLightTextStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 35, 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/orderIcon.svg',
                                                ),
                                                SizedBox(
                                                  width: 9,
                                                ),
                                                Text(
                                                  'معلومات الطلب',
                                                  style: MyCustomTextStyle
                                                      .myTextButtonTextStyle,
                                                ),
                                                Spacer(),
                                                Text(
                                                  '#100182454',
                                                  style: MyCustomTextStyle
                                                      .myTextButtonTextStyleWithOpacity,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: List.generate(
                                                  4,
                                                  (index) => Padding(
                                                    padding: index == 0
                                                        ? EdgeInsets.only(
                                                            bottom: 6)
                                                        : EdgeInsets.symmetric(
                                                            vertical: 6),
                                                    child: Container(
                                                      color: Colors.white,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 14, 35, 14),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                              child:
                                                                  CachedNetworkImage(
                                                                // imageUrl: datum.meals!.first.meal!.attachments!.first.link!,

                                                                imageUrl:
                                                                    // homeResturante.image ??
                                                                    'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  width: 60,
                                                                  height: 45,
                                                                  decoration: BoxDecoration(
                                                                      image: DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .cover)),
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Container(
                                                                        height:
                                                                            70,
                                                                        width:
                                                                            95,
                                                                        child: Center(
                                                                            child:
                                                                                const CircularProgressIndicator())),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Container(
                                                                  height: 70,
                                                                  width: 95,
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .broken_image,
                                                                    color:
                                                                        myGreyColor,
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
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .stretch,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    // datum.meals!.first.meal!.name!,
                                                                    'وجبة برجر',
                                                                    style: MyCustomTextStyle
                                                                        .myH2TextStyle,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Text(
                                                                    "fdg",
                                                                    // mealDetailsData.description!,
                                                                    // datum.meals!.first.meal!.description!,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: MyCustomTextStyle
                                                                        .myP1WithOpacity,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            Text(
                                                              "1X",
                                                              style: MyCustomTextStyle
                                                                  .myCardtextStyle,
                                                            ),
                                                            SizedBox(
                                                              width: 17,
                                                            ),
                                                            Text(
                                                              "13 ر.ع",
                                                              style: MyCustomTextStyle
                                                                  .myCardtextStyle,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                right: SizeConfig.screenWidth / 4,
                                top: 0,
                                child: Container(
                                  width: 188,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                    color: mySecondaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'وقت الوصول المتوقع 13.40',
                                      style: MyCustomTextStyle.myOrderDetailsH1,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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
