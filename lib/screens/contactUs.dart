import 'dart:convert';
import 'dart:io';

import 'package:brsel_application/componantes/myButton.dart';
import 'package:brsel_application/componantes/myIconButton.dart';
import 'package:brsel_application/componantes/mySettingsSecCustomAppBar.dart';
import 'package:brsel_application/constants.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:brsel_application/size_config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  bool switchValue = false;
  bool loading = false;
  bool pickFileLoading = false;
  PlatformFile? pickedFile;
  String? token;
  int? id;

  final _formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();

  Future pickFile() async {
    setState(() {
      pickFileLoading = true;
    });
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result == null) {
        setState(() {
          pickFileLoading = false;
        });
      } else {
        setState(() {
          pickedFile = result.files.first;
        });
      }
    } on PlatformException catch (e) {}
    setState(() {
      pickFileLoading = false;
    });
  }

  Future<File> createFilePath() async {
    final file = File(pickedFile!.path!);
    return file;
  }

  Future getSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
      id = preferences.getInt('ID');
    });
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
            MySettingsSecCustomAppBar(
              title: 'تواصل معنا',
              leading: MyIconButton(
                onPress: () {
                  // Get.back();
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'أدخل رسالتك هنا',
                                  style: MyCustomTextStyle
                                      .mySettingsTitleTextStyle,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  maxLength: 700,
                                  maxLines: 20,
                                  controller: messageController,
                                  validator: (val) =>
                                      val!.isEmpty ? 'أدخل نص الرسالة' : null,
                                  style: MyCustomTextStyle.myH1TextStyle,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle:
                                        MyCustomTextStyle.myHintTextStyle,
                                    hintText: 'أكتب رسالتك هنا',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 11, vertical: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        width: 1.0,
                                        color: myBackgroundFillingColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: BorderSide(
                                        width: 1.0,
                                        color: myGreyColor.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                // Text(
                                //   'نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف. خمسة قرون من الزمن لم تقضي على هذا النص، بل انه حتى صار مستخدماً وبشكله الأصلي في الطباعة والتنضيد الإلكتروني. انتشر بشكل كبير في ستينيّات هذا القرن مع إصدار رقائق "ليتراسيت" (Letraset) البلاستيكية تحوي مقاطع من هذا النص، وعاد لينتشر مرة أخرى مؤخراَ مع ظهور برامج النشر الإلكتروني مثل "ألدوس بايج مايكر" (Aldus PageMaker) والتي حوت أيضاً على نسخ من نص لوريم إيبسوم.',
                                //   style: TextStyle(
                                //       fontSize: 12,
                                //       color: mySecGreyColor,
                                //       fontWeight: FontWeight.w300,
                                //       height: 1.5),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            if (pickFileLoading == true) ...[
                              Container(
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 17, 15, 17),
                                  child: Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ] else if (pickedFile != null) ...[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: RichText(
                                          textAlign: TextAlign.right,
                                          overflow: TextOverflow.clip,
                                          text: TextSpan(
                                            text: 'الملف: ${pickedFile!.name}',
                                            style: MyCustomTextStyle
                                                .mySettingsTitleTextStyle,
                                          ),
                                        ),
                                      ),
                                      // Material(
                                      // child:
                                      IconButton(
                                        constraints: BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                        onPressed: () async {
                                          pickFile();
                                        },
                                        icon: Icon(
                                          BrselApp.attachicon,
                                          color: mylighterDarkBlueColor,
                                        ),
                                      ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ] else ...[
                              InkWell(
                                onTap: () async {
                                  pickFile();
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(15, 15, 15, 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'ارفاق ملفات',
                                          style: MyCustomTextStyle
                                              .mySettingsTitleTextStyle,
                                        ),
                                        Icon(
                                          BrselApp.attachicon,
                                          color: mylighterDarkBlueColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: MyButton(
                          loading: loading,
                          title: 'حفظ ومتابعة',
                          color: mySecondaryColor,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (pickedFile == null) {
                                Fluttertoast.showToast(
                                    msg: "يجب ارفاق الملف المطلوب",
                                    backgroundColor: myDarkGreyColor);
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                File file = await createFilePath();
                                await getSharedPreferences();

                                var response = await RemoteServices.contacUs(
                                    userID: id.toString(),
                                    message: messageController.toString(),
                                    file: file,
                                    access_token: token!);

                                if (response.toString() ==
                                    "تم ارسال طلبك بنجاح") {
                                  Fluttertoast.showToast(
                                      msg: "تم ارسال رسالتك بنجاح",
                                      backgroundColor: myDarkGreyColor);
                                  Navigator.pop(context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "يوجد مشكلة, تأكد من أن نوع الملف pdf أو docx. أعد المحاولة لاحقاً",
                                      backgroundColor: myDarkGreyColor);
                                }
                                setState(() {
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
