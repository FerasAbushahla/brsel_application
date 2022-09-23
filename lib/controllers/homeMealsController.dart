import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';

class HomeMealsController extends GetxController {
  static var isLoading = true.obs;
  var homeMealsList = <HomeMeals>[].obs;

  @override
  void onInit() {
    getHomeMeals();
    super.onInit();
  }

  void getHomeMeals() async {
    try {
      isLoading(true);
      var homeMeals = await RemoteServices.getHomeMeals(
          access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
      homeMealsList.value = homeMeals;
    } finally {
      isLoading(false);
    }
  }
}
