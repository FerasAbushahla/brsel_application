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
  var totalprice = 0.0.obs;
  String? token;

  @override
  void onInit() {
    // getSharedPrefs().then((value) => getOrders());
    getOrders().then((value) {
      getOrdersPrice();
      super.onInit();
    });
    // getOrdersPrice();
  }

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    token = preferences.getString('token');

    print('ordersController token: $token');
  }

  Future getOrders() async {
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

  Future deleteOrder(int index) async {
    LocaleDBHelper.dbHelper.deleteOrder(index);
    await getOrders();
    await getOrdersPrice();
  }

  Future getOrdersPrice() async {
    double totallprice = 0;
    print(totallprice);
    print('getOrdersPrice');
    try {
      print('try');
      print('ordersList.length ${ordersList.length}');
      isLoading(true);
      for (var i = 0; i < ordersList.length; i++) {
        print('{ordersList[i]}  ${ordersList[i]}');
        totallprice += double.parse(ordersList[i].price!);
        print('totallprice $totallprice');

        // totalprice += double.parse(ordersList[i].price!);

        print('Total price ${totalprice}');
      }
      totalprice.value = totallprice;
      totallprice = 0;
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
