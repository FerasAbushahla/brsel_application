import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';

class HomeADsSliderController extends GetxController {
  static var isLoading = true.obs;
  var homeSliderList = <HomeSlider>[].obs;

  @override
  void onInit() {
    getHomeSlider();
    super.onInit();
  }

  void getHomeSlider() async {
    try {
      isLoading(true);
      var homeSlider = await RemoteServices.getHomeSlider(
          access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
      homeSliderList.value = homeSlider;
    } finally {
      isLoading(false);
    }
  }
}
