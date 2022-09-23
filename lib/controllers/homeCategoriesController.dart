import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';

class HomeCategoriesController extends GetxController {
  static var isLoading = true.obs;
  var homeCategoriesList = <HomeCategories>[].obs;

  @override
  void onInit() {
    getHomeCategories();
    super.onInit();
  }

  void getHomeCategories() async {
    try {
      isLoading(true);
      var homeCategories = await RemoteServices.getHomeCategories(
          access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
      homeCategoriesList.value = homeCategories;
    } finally {
      isLoading(false);
    }
  }
}
