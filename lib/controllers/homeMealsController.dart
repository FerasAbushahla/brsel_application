import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMealsController extends GetxController {
  static var isLoading = true.obs;
  var homeMealsList = <HomeMeals>[].obs;
  String? token;

  @override
  void onInit() {
    getSharedPrefs().then((value) => getHomeMeals());

    super.onInit();
  }

  Future getSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    token = preferences.getString('token');

    print('homeMealsController token: $token');
  }

  void getHomeMeals() async {
    try {
      isLoading(true);
      var homeMeals = await RemoteServices.getHomeMeals(access_token: token);
      // access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
      homeMealsList.value = homeMeals;
    } finally {
      isLoading(false);
    }
  }
}
