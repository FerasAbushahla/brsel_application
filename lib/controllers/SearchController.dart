import 'package:brsel_application/models/SearchModel.dart';
import 'package:brsel_application/models/homeModel.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchController extends GetxController {
  static var isLoading = true.obs;
  var searchList = <SearchData>[].obs;
  String? token;

  @override
  void onInit() {
    getSharedPrefs().then((value) => getSearchMeals());
    // getHomeMeals();

    super.onInit();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  // }

  Future getSharedPrefs() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      token = preferences.getString('token');

      print('MealDetailsController token: $token');
    } catch (e) {
      print(e);
    }
  }

  void getSearchMeals({String? word}) async {
    try {
      isLoading(true);
      print(isLoading);
      print('token....$token');
      var search = await RemoteServices.getSearchMeals(
          access_token: token, searchWord: word == null ? "" : word);
      // var homeMeals = await RemoteServices.getHomeMeals(
      //     access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
      // access_token: '5|IHLNEHPjbGfserZVbDfBMuyoJsHcmzbHZt0VHV1Z');
      searchList.value = search;
    } finally {
      isLoading(false);
    }
  }
}
