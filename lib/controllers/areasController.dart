import 'package:brsel_application/models/areasModel.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AreasController extends GetxController {
  static var isLoading = true.obs;
  var areasList = <AreasDatum>[].obs;
  String? token;

  @override
  void onInit() async {
    await getSharedPrefs().then((value) => getAreas());
  }

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('token');

    print('ordersController token: $token');
  }

  Future getAreas() async {
    try {
      isLoading(true);

      AreasModel? areasModel = await RemoteServices.getAreas(
        access_token: token,
      );

      areasList.value = areasModel!.data!;
    } finally {
      isLoading(false);
    }
  }
}
