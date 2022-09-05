import 'dart:convert';
import 'dart:io';

import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/componantes/myCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/screens/location.dart';
import 'package:brsel_application/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../componantes/myIconButton.dart';

class PersonalImage extends StatefulWidget {
  const PersonalImage({Key? key}) : super(key: key);

  @override
  State<PersonalImage> createState() => _PersonalImageState();
}

class _PersonalImageState extends State<PersonalImage> {
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

  File? image;

  Future pickImage({ImageSource? source}) async {
    try {
      setState(() {
        loading = true;
      });
      final image = await ImagePicker().pickImage(source: source!);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      // final img = Image.file(imageTemporary);
      final bytes = File(image.path).readAsBytesSync();
      print(bytes);
      // ByteData bytes = await rootBundle.load(image.path);
      String base64Image = base64Encode(bytes.buffer.asUint8List());
      print(base64Image);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('personalImage', base64Image);
      setState(() {
        loading = false;
      });
    } on PlatformException catch (e) {
      print('error picking image: $e');
    }
  }

  Future<bool> saveImage(List<int> imageBytes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String base64Image = base64Encode(imageBytes);
    return prefs.setString("image", base64Image);
  }

  bool loading = false;

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
                  'الصورة الشخصية',
                  textAlign: TextAlign.center,
                  style: MyCustomTextStyle.myTitletextStyle,
                ),
              ),
              SizedBox(
                height: 13,
              ),
              SvgPicture.asset('assets/images/PersonalInfoProgress2.svg',
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
                  if (loading == true) ...[
                    CircularProgressIndicator(),
                  ] else ...[
                    Column(
                      children: [
                        if (image == null) ...[
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 36),
                                child: InkWell(
                                  onTap: () {
                                    pickImage(source: ImageSource.camera)
                                        .then((value) => setState(() {
                                              loading = false;
                                            }));
                                  },
                                  child: Container(
                                    width: SizeConfig.screenWidth,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 17),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                color: myPrimaryColor
                                                    .withOpacity(0.3),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Image.asset(
                                                    'assets/images/Gallery.png'),
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
                                            'التقط صورة',
                                            style: MyCustomTextStyle
                                                .myNormaltextStyle,
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 36),
                                child: InkWell(
                                  onTap: () =>
                                      pickImage(source: ImageSource.gallery)
                                          .then((value) => setState(() {
                                                loading = false;
                                              })),
                                  child: Container(
                                    width: SizeConfig.screenWidth,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 17),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                color: myPrimaryColor
                                                    .withOpacity(0.3),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Image.asset(
                                                    'assets/images/Gallery.png'),
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
                                            'اختيار من الاستيديو',
                                            style: MyCustomTextStyle
                                                .myNormaltextStyle,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ] else if (image != null) ...[
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: SizedBox(
                                  width: 236,
                                  height: 236,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, bottom: 15),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.file(
                                        image!,
                                        height: 215,
                                        width: 215,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: ClipOval(
                                  child: Material(
                                    color: myPrimaryColor,
                                    child: InkWell(
                                      // splashColor: Colors.red, // Splash color
                                      onTap: () {
                                        setState(() {
                                          image = null;
                                        });
                                      },
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ],
                ],
              ),
              SizedBox(
                height: 110,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: MyButton(
                  loading: loading,
                  title: 'حفظ ومتابعة',
                  onPressed: () async {
                    if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("يجب اختيار صورة شخصية"),
                        ),
                      );
                    } else if (image != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Location()));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
