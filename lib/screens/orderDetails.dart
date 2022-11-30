import 'dart:async';
import 'dart:io';
import 'package:brsel_application/componantes/myOrderDetailsCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition muscatPosition =
      CameraPosition(target: LatLng(23.5880, 58.3829), zoom: 12);
  Set<Marker> markers = {};

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
                  SizedBox(
                    height: 350,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 14,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(34),
                                    topRight: Radius.circular(34),
                                  ),
                                  color: Colors.white,
                                ),
                                height: 420,
                                width: SizeConfig.screenWidth,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                    )
                                  ],
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
            )
          ],
        ),
      ),
    );
  }
}
