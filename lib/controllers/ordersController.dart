import 'package:brsel_application/models/SearchModel.dart';
import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/models/mealDetailsModel.dart';
import 'package:brsel_application/service/hiveDB.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersController extends GetxController {
  static var isLoading = true.obs;
  var ordersList = <MealDetailsData>[].obs;
  String? token;

  @override
  void onInit() {
    // getSharedPrefs().then((value) => getOrders());
    getOrders();

    super.onInit();
  }

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    token = preferences.getString('token');

    print('ordersController token: $token');
  }

  void getOrders() async {
    try {
      isLoading(true);
      int length = await LocaleDBHelper.dbHelper.getLocalOrdersListLength();
      print('length ${length}');
      var order = await LocaleDBHelper.dbHelper.getAllOrders();
      // RemoteServices.getSearchMeals(
      //     access_token: token, searchWord: word == null ? "" : word);
      // var homeMeals = await RemoteServices.getHomeMeals(
      //     access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
      // access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
      ordersList.value = order;
    } finally {
      isLoading(false);
    }
  }
}
