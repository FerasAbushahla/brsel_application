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
      final orderBox = await Hive.box('orderBox');
      await orderBox.add(order);
    } on Exception catch (e) {
      // TODO
    }
  }

  Future deleteOrdersLocal() async {
    final orderBox = await Hive.box('orderBox');
    await orderBox.clear();
    print('deleteOrdersLocal');
    print('length ${orderBox.length}');
  }

  Future deleteOrder(int index) async {
    try {
      final orderBox = await Hive.box('orderBox');
      await orderBox.deleteAt(index);
      print('deleteOrder');
      print('length ${orderBox.length}');
    } catch (e) {
      print(e);
    }
  }

  Future<List<MealDetailsData>> getAllOrders() async {
    print('getAllOrders');
    List<MealDetailsData> orders = [];
    final orderBox = await Hive.box('orderBox');
    // orderBox.getAt(1);
    // print(orderBox.getAt(0));
    // print(orderBox.getAt(1));
    // print(surveyBox.getAt(2));
    for (var i = 0; i < orderBox.length; i++) {
      print(orderBox.getAt(i));
      Map<dynamic, dynamic> order = await orderBox.getAt(i);

      orders.add(MealDetailsData.fromJson(order));
      print(orders);
    }
    return orders;
  }

  Future<int> getLocalOrdersListLength() async {
    final orderBox = await Hive.box('orderBox');
    return orderBox.length;
  }

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
