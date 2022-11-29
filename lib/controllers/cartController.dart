import 'package:brsel_application/models/mealDetailsModel.dart';
import 'package:brsel_application/service/hiveDB.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  static var isLoading = true.obs;

  var cartList = <MealDetailsData>[].obs;
  var totalprice = 0.0.obs;
  var cartListLength = 0.obs;
  RxBool isButtonDisabled = true.obs;
  String? token;

  @override
  void onInit() async {
    // isLoading(true);
    // getSharedPrefs().then((value) => getOrders());
    await getCartOrders().then((value) async {
      await getCartOrdersPrice();
      await getcartListLength();

      super.onInit();
    });
    // isLoading(false);
    // getOrdersPrice();
  }

  Future<int> getMealCount(int id) async {
    int meal = await LocaleDBHelper.dbHelper.getMealCount(id);
    return meal;
  }

  Future<int> getIndex(int id) async {
    int index = await LocaleDBHelper.dbHelper.getIndex(id);
    return index;
  }

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    token = preferences.getString('token');

    print('ordersController token: $token');
  }

  Future getcartListLength() async {
    cartListLength.value = cartList.length;
    update();
  }

  Future getCartOrders() async {
    // isLoading.value = true;
    try {
      int length = await LocaleDBHelper.dbHelper.getLocalOrdersListLength();
      print('length ${length}');
      var order = await LocaleDBHelper.dbHelper.getAllOrders();
      print('order ${order}');
      // RemoteServices.getSearchMeals(
      //     access_token: token, searchWord: word == null ? "" : word);
      // var homeMeals = await RemoteServices.getHomeMeals(
      //     access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
      // access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
      cartList.value = order;
      await getcartListLength();
    } finally {
      // isLoading.value = false;
    }
  }
  // Future getCartOrders() async {
  //   try {
  //     isLoading(true);
  //     int length = await LocaleDBHelper.dbHelper.getLocalOrdersListLength();
  //     print('length ${length}');
  //     var order = await LocaleDBHelper.dbHelper.getAllOrders();
  //     // RemoteServices.getSearchMeals(
  //     //     access_token: token, searchWord: word == null ? "" : word);
  //     // var homeMeals = await RemoteServices.getHomeMeals(
  //     //     access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
  //     // access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
  //     cartList.value = order;
  //     await getcartListLength();
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future deleteOrder(int index) async {
    LocaleDBHelper.dbHelper.deleteOrder(index);
    await getCartOrders();
    await getCartOrdersPrice();
  }

  Future getCartOrdersPrice() async {
    double totallprice = 0;
    print(totallprice);
    print('getOrdersPrice');
    try {
      print('try');
      print('ordersList.length ${cartList.length}');
      isLoading(true);
      for (var i = 0; i < cartList.length; i++) {
        print('{ordersList[i]}  ${cartList[i]}');
        print('cartList[i].count!  ${cartList[i].count!}');
        totallprice += double.parse(cartList[i].price!) * cartList[i].count!;
        print('totallprice $totallprice');

        // totalprice += double.parse(ordersList[i].price!);

        print('Total price ${totalprice}');
      }
      totalprice.value = totallprice;
      totallprice = 0;
      if (totalprice.value > 0) {
        isButtonDisabled.value = false;
      } else {
        isButtonDisabled.value = true;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  // Future<bool> checkMealById(String id) async {
  //   bool isFound = await LocaleDBHelper.dbHelper.checkMealById(id);
  //   return isFound;
  // }
}
