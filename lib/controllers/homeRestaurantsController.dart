import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';

class HomeRestaurantsController extends GetxController {
  static var isLoading = true.obs;
  var homeResraurantsList = <HomeResturante>[].obs;

  @override
  void onInit() {
    getHomeRestaurants();
    super.onInit();
  }

  void getHomeRestaurants() async {
    try {
      isLoading(true);
      var homeRestaurants = await RemoteServices.getHomeRestaurants(
          access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
      homeResraurantsList.value = homeRestaurants;
    } finally {
      isLoading(false);
    }
  }
}
