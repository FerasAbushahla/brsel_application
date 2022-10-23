import 'package:brsel_application/controllers/userController.dart';
import 'package:brsel_application/models/mealDetailsModel.dart';
import 'package:brsel_application/models/userModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

class LocaleDBHelper {
  /// singlton
  LocaleDBHelper._();
  static final LocaleDBHelper dbHelper = LocaleDBHelper._();

  /// initial database
  initDB() async {
    final dir = await path.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.initFlutter('hive_db');

    await Hive.openBox('orderBox');
  }

  /// create table
  addOrderLocally(MealDetailsData order) async {
    try {
      final userBox = await Hive.box('orderBox');
      await userBox.add(order);
    } on Exception catch (e) {
      // TODO
    }
  }

  deleteUserLocal() async {
    final userBox = await Hive.box('user');
    await userBox.clear();
    print(userBox.length);
  }

  // Future<List<Survey>> getAllSurveys() async {
  //   print('getAllSurveys');
  //   List<Survey> surveys = [];
  //   final surveyBox = await Hive.box('survey');
  //   // surveyBox.getAt(1);
  //   // print(surveyBox.getAt(0));
  //   // print(surveyBox.getAt(1));
  //   // print(surveyBox.getAt(2));
  //   Map<dynamic, dynamic> survey = await surveyBox.getAt(0);

  //   surveys.add(Survey.fromJson(survey));
  //   // for (var i = 0; i < surveyBox.length; i++) {
  //   //   print(surveyBox.getAt(i));
  //   //   Map<dynamic, dynamic> survey = await surveyBox.getAt(i);

  //   //   surveys.add(Survey.fromJson(survey));
  //   //   print(surveys);
  //   // }
  //   return surveys;
  // }
  // Future<List<Survey>> getAllSurveys() async {
  //   print('getAllSurveys');
  //   List<Survey> surveys = [];
  //   final surveyBox = await Hive.box('survey');
  //   // surveyBox.getAt(1);
  //   // print(surveyBox.getAt(0));
  //   // print(surveyBox.getAt(1));
  //   // print(surveyBox.getAt(2));
  //   for (var i = 0; i < surveyBox.length; i++) {
  //     print(surveyBox.getAt(i));
  //     Map<dynamic, dynamic> survey = await surveyBox.getAt(i);

  //     surveys.add(Survey.fromJson(survey));
  //     print(surveys);
  //   }
  //   return surveys;
  // }

  // Future<int> getLocalSurveyListLength() async {
  //   final surveyBox = await Hive.box('survey');
  //   return surveyBox.length;
  // }
}
