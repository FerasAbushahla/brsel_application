import 'package:brsel_application/models/orderHistoryModel.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistoryController extends GetxController {
  static var isLoading = true.obs;
  var orderList = <Datum>[].obs;
  String? token;
  RxDouble? spentAmount = 0.0.obs;

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
      await getAmountSpent();

      OrderHistoryModel? orderHistory = await RemoteServices.getOrdersHistory(
        access_token: token,
      );

      orderList.value = orderHistory!.data!;
    } finally {
      isLoading(false);
    }
  }

  // Future getSpentAmount() async {
  //   double total = 0;
  //   orderList.forEach((element) {
  //     total += double.parse(element.totalPrice!);
  //     print('total ${total}');
  //   });
  //   print('total 2 ${total}');
  //   spentAmount!.value = total;
  //   print('spentAmount ${spentAmount}');
  // }
  Future getAmountSpent() async {
    double total = 0;
    for (var i = 0; i < orderList.length; i++) {
      total += double.parse(orderList[i].totalPrice!);
      print('total ${total}');
    }

    print('total 2 ${total}');
    spentAmount!.value = total;
    print('spentAmount ${spentAmount}');
  }
}
