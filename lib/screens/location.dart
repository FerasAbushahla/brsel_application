import 'dart:async';
import 'package:brsel_application/componantes/myCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../componantes/myButton.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  void initState() {
    Future.delayed(const Duration(milliseconds: 5), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      print('personalImagePage......................');
      print(preferences.get('firstName'));
      print(preferences.get('lastName'));
      print(preferences.get('phoneNumber'));
      print(preferences.get('sex'));
      print(preferences.get('token'));
      print(preferences.get('personalImage'));
      // userBox = Hive.box('user');
      // var myUser = await userBox.getAt(0);
      // print(myUser);
    });
    super.initState();
  }

  bool loading = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: MyCustomAppBar(
        leading: Column(
          children: [
            SizedBox(
              height: 11,
            ),
            MyIconButton(
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 125),
                child: Text(
                  'الموقع',
                  textAlign: TextAlign.center,
                  style: MyCustomTextStyle.myTitletextStyle,
                ),
              ),
              SizedBox(
                height: 13,
              ),
              SvgPicture.asset('assets/images/PersonalInfoProgress3.svg',
                  height: getProportionalScreenHeight(24)),
              SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Text(
                  'سيتم عرض هذه البيانات في ملف تعريف حسابك للأمان',
                  textAlign: TextAlign.center,
                  style: MyCustomTextStyle.myBigtextStyle,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  if (index == 0) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        child: Container(
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: myPrimaryColor.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Icon(
                                        size: 26,
                                        Icons.location_on_outlined,
                                        color: myPrimaryColor,
                                      ),
                                    )
                                    // SvgPicture.asset(
                                    //   'assets/images/Gallery.svg',
                                    //   color: myPrimaryColor,
                                    //   height: getProportionalScreenHeight(60),
                                    // ),
                                    ),
                                SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  'اعداد الموقع',
                                  style: MyCustomTextStyle.myNormaltextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                  ] else if (index == 1) ...[
                    MyMap(loading: loading),
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyMap extends StatefulWidget {
  const MyMap({
    Key? key,
    required this.loading,
  }) : super(key: key);

  final bool loading;

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();

  static final Marker marker = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google plex'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(37.773972, -122.431297),
  );

  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(37.773972, -122.431297), zoom: 12);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: SizedBox(
            height: 250,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: {marker},
              // initialCameraPosition: CameraPosition(
              //     target: LatLng(37.773972, -122.431297), zoom: 12),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            height: 65,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: myPrimaryColor.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Icon(
                              size: 26,
                              Icons.location_on_outlined,
                              color: myPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'الموقع',
                            style: MyCustomTextStyle.myCardTitletextStyle,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'مسقط ,عمان,1988',
                            style: MyCustomTextStyle.myCardtextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ClipOval(
                      child: Material(
                        color: myPrimaryColor,
                        child: InkWell(
                          // splashColor: Colors.red, // Splash color
                          onTap: () {
                            // setState(() {
                            //   image = null;
                            // });
                          },
                          child: SizedBox(
                            width: 28,
                            height: 28,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 45,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: MyButton(
            loading: widget.loading,
            title: 'حفظ ومتابعة',
            onPressed: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Location()));
            },
          ),
        ),
      ],
    );
  }
}
