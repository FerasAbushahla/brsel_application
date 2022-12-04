import 'package:brsel_application/models/mealDetailsModel.dart';
import 'package:brsel_application/models/orderHistoryModel.dart';
import 'package:brsel_application/service/hiveDB.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsController extends GetxController {
  static var isLoading = true.obs;
  RxObjectMixin orderDetails = Datum().obs;
  String? token;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSharedPrefs();
  }

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    token = preferences.getString('token');

    print('ordersController token: $token');
  }

  // Future getOrderMealsListLength() async {
  //   cartListLength.value = cartList.length;
  //   update();
  // }

  Future getOrderDetails({int? orderID}) async {
    try {
      isLoading.value = true;
      Datum? orderHistory = await RemoteServices.getOrderDetails(
        access_token: token,
        orderID: orderID,
      );

      orderDetails.value = orderHistory;
      print('orderDetails ${orderDetails.value}');
    } finally {
      isLoading.value = false;
    }
  }
}
