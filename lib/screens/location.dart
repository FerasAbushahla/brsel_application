import 'dart:async';
import 'dart:io';

import 'package:brsel_application/componantes/myCustomAppBar.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/models/personalInfoModel.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:brsel_application/size_config.dart';
import 'package:brsel_application/wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../componantes/myButton.dart';

class Location extends StatefulWidget {
  final bool fromSettings;
  final File? image;
  const Location({Key? key, this.image, required this.fromSettings})
      : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  void initState() {
    Future.delayed(const Duration(milliseconds: 5), () async {
      if (widget.fromSettings == true) {
        setState(() {
          index = 1;
        });
      } else {
        setState(() {
          index = 0;
        });
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      print('personalImagePage......................');
      print(preferences.get('firstName'));
      print(preferences.get('lastName'));
      print(preferences.get('phoneNumber'));
      print(preferences.get('sex'));
      print(preferences.get('token'));
      print(preferences.get('personalImage'));
      print(preferences.get('personalImageFileLocation'));
      // userBox = Hive.box('user');
      // var myUser = await userBox.getAt(0);
      // print(myUser);
    });
    super.initState();
  }

  bool loading = false;
  int index = 0;
  // String? lat;
  // String? long;

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
                // Navigator.pop(context);
                Get.back();
                // Get.off(PersonalImage(fromSettings: false));
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
                        onTap: () async {
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
                    CurrentLocationMap(
                        image: widget.image, fromSettings: widget.fromSettings),
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

class CurrentLocationMap extends StatefulWidget {
  final bool fromSettings;
  final File? image;
  const CurrentLocationMap({super.key, this.image, required this.fromSettings});

  @override
  State<CurrentLocationMap> createState() => _CurrentLocationMapState();
}

class _CurrentLocationMapState extends State<CurrentLocationMap> {
  bool loading = false;
  bool determinePositionLoading = false;
  bool mapLoading = false;
  var address;
  Position? currentPosition;

  String? userAddress;
  int? userID;
  String? userFirstName;
  String? userLastName;
  String? userPhoneNumber;
  String? userGender;
  String? userImage;
  String? userLat;
  String? userLong;
  String? accessToken;
  String? userStreet;
  String? userLocality;
  String? userCountry;

  late GoogleMapController googleMapController;
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition cameraPosition;

  static final CameraPosition muscatPosition =
      CameraPosition(target: LatLng(23.5880, 58.3829), zoom: 12);
  late CameraPosition userPosition = CameraPosition(
      target: LatLng(double.parse(userLat!), double.parse(userLong!)),
      zoom: 12);
  List<Placemark>? userCurrentPlace;

  Set<Marker> markers = {};

  Future getSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userAddress = sharedPreferences.getString('currentPosition');
      userFirstName = sharedPreferences.getString('firstName');
      userLastName = sharedPreferences.getString('lastName');
      userGender = sharedPreferences.getString('sex');
      userImage = sharedPreferences.getString('personalImage');
      userLat = sharedPreferences.getString('currentPositionLatitude');
      userLong = sharedPreferences.getString('currentPositionLongitude');
      userPhoneNumber = sharedPreferences.getString('phoneNumber');
      userID = sharedPreferences.getInt('ID');
      accessToken = sharedPreferences.getString('token');
      userStreet = sharedPreferences.getString('currentStreetPosition');
      userLocality = sharedPreferences.getString('currentLocalityPosition');
      userCountry = sharedPreferences.getString('currentCountryPosition');
    });
    print('userStreet $userStreet');
    print('userLocality $userLocality');
    print('userCountry $userCountry');
    print('userLattttttttt $userLat');
  }

  Future displaySavedLocation() async {
    try {
      // setState(() {
      //   mapLoading = true;
      // });
      await getSharedPreferences();
      print('userLonggg  $userLong');
      print('userLattt  $userLat');
      print('userLonggg double  ${double.parse(userLong!)}');

      double doubleLat = double.parse(userLat!);
      double doubleLong = double.parse(userLong!);
      final GoogleMapController controller = await _controller.future;

      controller.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(doubleLat, doubleLong), zoom: 12)));

      // await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      //   CameraPosition(target: LatLng(31.5148864, 34.4519451), zoom: 12),
      // ));
      // setState(() {});

      markers.clear();
      markers.add(Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(double.parse(userLat!), double.parse(userLong!))));

      List<Placemark> placemark = await placemarkFromCoordinates(
          double.parse(userLat!), double.parse(userLong!),
          localeIdentifier: "ar");

      setState(() {
        mapLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // Timer(Duration(milliseconds: 500), () {
    getSharedPreferences();
    print('userLocality $userLocality');
    displaySavedLocation();
    // });
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: SizedBox(
            height: 250,
            child:
                // mapLoading
                //     ? Center(
                //         child: SizedBox(
                //             height: 30,
                //             width: 30,
                //             child: CircularProgressIndicator()))
                //     :
                GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: muscatPosition,
              // userLat == null ? muscatPosition : muscatPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                googleMapController = controller;
              },
              markers: markers,
              zoomControlsEnabled: false,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (userLat == null) ...[
                // Container(
                //   decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(6),
                // ),
                // height: 65,
                // child: ,
                // ),

                MyButton(
                  title: "حدد موقعك الحالي",
                  circularProgressColor: mySecondaryColor,
                  loading: determinePositionLoading,
                  color: myPrimaryColor,
                  onPressed: () async {
                    setState(() {
                      determinePositionLoading = true;
                    });
                    Position position = await _determinePosition();

                    googleMapController
                        .animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 12),
                    ));
                    markers.clear();
                    markers.add(Marker(
                        markerId: const MarkerId('currentLocation'),
                        position:
                            LatLng(position.latitude, position.longitude)));

                    List<Placemark> placemark = await placemarkFromCoordinates(
                        position.latitude, position.longitude,
                        localeIdentifier: "ar");
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();

                    setState(() {
                      currentPosition = position;
                      userCurrentPlace = placemark;
                      print('userCurrentPlace $userCurrentPlace');
                      print('userCurrentPlace ${userCurrentPlace.toString()}');
                      sharedPreferences.setString(
                          'userCurrentPlace', userCurrentPlace.toString());

                      print(
                          'current location in detail country:${placemark[0].locality}, country:${placemark[0].locality},subLocality:${placemark[0].subLocality}, street:${placemark[0].street},');
                      // print(userCurrentPlace!.elementAt(0).toString());
                      print(userCurrentPlace![0].toJson());
                      sharedPreferences.setString('currentPositionDetailed',
                          userCurrentPlace![0].toJson().toString());
                      sharedPreferences.setString('currentPosition',
                          '${userCurrentPlace![0].country}, ${userCurrentPlace![0].locality}, ${userCurrentPlace![0].street}');
                      print(
                          'Preferences currentPosition::::::: ${sharedPreferences.setString('currentPosition', '${userCurrentPlace![0].country}, ${userCurrentPlace![0].locality}, ${userCurrentPlace![0].street}')}');
                      print(sharedPreferences.get('currentPosition'));
                      sharedPreferences.setString('currentCountryPosition',
                          '${userCurrentPlace![0].country}');
                      sharedPreferences.setString('currentLocalityPosition',
                          '${userCurrentPlace![0].locality}');
                      sharedPreferences.setString('currentStreetPosition',
                          '${userCurrentPlace![0].street}');
                      sharedPreferences.setString('currentPositionLatitude',
                          position.latitude.toString());
                      sharedPreferences.setString('currentPositionLongitude',
                          position.longitude.toString());
                      sharedPreferences.setString('currentStreetPosition',
                          '${userCurrentPlace![0].street}');
                      userStreet = userCurrentPlace![0].street;

                      userLat = sharedPreferences
                          .getString('currentPositionLatitude');

                      // print(address.value =
                      //     'Address: ${userCurrentPlace![0].locality ?? userCurrentPlace![0].street}');

                      determinePositionLoading = false;
                    });
                  },
                ),
              ] else ...[
                Container(
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
                                Column(
                                  children: [
                                    if (userLocality == null) ...[
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        userStreet!,
                                        style:
                                            MyCustomTextStyle.myCardtextStyle,
                                      ),
                                    ] else ...[
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        '$userCountry, $userLocality, $userStreet',
                                        // 'مسقط ,عمان,1988',
                                        style:
                                            MyCustomTextStyle.myCardtextStyle,
                                      ),
                                    ]
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 8),
                        //   child: ClipOval(
                        //     child: Material(
                        //       color: myPrimaryColor,
                        //       child: InkWell(
                        //         // splashColor: Colors.red, // Splash color
                        //         onTap: () async {
                        //           await getSharedPreferences();
                        //         },
                        //         child: SizedBox(
                        //           width: 28,
                        //           height: 28,
                        //           child: Icon(
                        //             Icons.edit,
                        //             color: Colors.white,
                        //             size: 20,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
        SizedBox(
          height: 45,
        ),
        if (widget.fromSettings) ...[
          Container()
        ] else ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: MyButton(
              loading: loading,
              color: mySecondaryColor,
              title: 'حفظ ومتابعة',
              onPressed: () async {
                if (userLat == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("يجب تحديد المكان الحالي"),
                    ),
                  );
                } else {
                  setState(() {
                    loading = true;
                  });
                  await getSharedPreferences();
                  // SharedPreferences sharedPreferences =
                  //     await SharedPreferences.getInstance();
                  // setState(() {
                  //   userAddress = sharedPreferences.getString('currentPosition');
                  //   userFirstName = sharedPreferences.getString('firstName');
                  //   userLastName = sharedPreferences.getString('lastName');
                  //   userGender = sharedPreferences.getString('sex');
                  //   userImage = sharedPreferences.getString('personalImage');
                  //   userLat =
                  //       sharedPreferences.getString('currentPositionLatitude');
                  //   userLong =
                  //       sharedPreferences.getString('currentPositionLongitude');
                  //   userPhoneNumber = sharedPreferences.getString('phoneNumber');
                  //   userID = sharedPreferences.getInt('ID');
                  //   accessToken = sharedPreferences.getString('token');
                  // });
                  print('widget.image ${widget.image}');
                  PersonalInfoModel personalInfoResponse =
                      await RemoteServices.userInfoRegister(
                    access_token: accessToken,
                    address: userAddress,
                    firstName: userFirstName,
                    lastName: userLastName,
                    gender: userGender,
                    image: widget.image,
                    lat: userLat,
                    long: userLong,
                    phoneNumber: userPhoneNumber,
                    userID: userID.toString(),
                    place_id: "1",
                  );
                  // if(personalInfoResponse.)
                  // PersonalInfoModel personalInfoResponse =
                  //     await RemoteServices.userInfoRegister(
                  //   address: userAddress,
                  //   firstName: userFirstName,
                  //   lastName: userLastName,
                  //   gender: userGender,
                  //   // image: userImage,
                  //   lat: userLat,
                  //   long: userLong,
                  //   phoneNumber: userPhoneNumber,
                  //   userID: userID.toString(),
                  // );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Wraper()));
                  setState(() {
                    loading = false;
                  });
                }
              },
            ),
          ),
        ]
      ],
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Get.snackbar('', 'Location Permission Denied');
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
