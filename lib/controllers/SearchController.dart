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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // userAddress = preferences.getString("currentPosition");
    token = preferences.getString('token');

    print('searchController token: $token');
  }

  void getSearchMeals({String? word}) async {
    try {
      isLoading(true);
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
