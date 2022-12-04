import 'package:brsel_application/models/orderHistoryModel.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistoryController extends GetxController {
  static var isLoading = true.obs;
  var orderList = <Datum>[].obs;
  String? token;

  @override
  void onInit() async {
    await getSharedPrefs().then((value) => getOrderHistory());
  }

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    token = preferences.getString('token');

    print('ordersController token: $token');
  }

  Future getOrderHistory() async {
    try {
      isLoading(true);

      OrderHistoryModel? orderHistory = await RemoteServices.getOrdersHistory(
        access_token: token,
      );

      orderList.value = orderHistory!.data!;
    } finally {
      isLoading(false);
    }
  }
}
