import 'package:brsel_application/models/SearchModel.dart';
import 'package:brsel_application/models/mealDetailsModel.dart';
import 'package:brsel_application/service/remoteServices.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealDetailsController extends GetxController {
  static var isLoading = true.obs;
  RxObjectMixin mealDetailsData = MealDetailsData().obs;
  var mealID = '0'.obs;
  String? token;

  // MealDetailsController({required this.mealID, this.token});
  @override
  void onInit() {
    // isLoading(true);
    getSharedPrefs();
    // getSharedPrefs().then((value) => getMealDetails(ID: mealID.value));
    // isLoading(false);

    super.onInit();
  }

  Future getSharedPrefs() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      token = preferences.getString('token');

      print('MealDetailsController token: $token');
    } catch (e) {
      print(e);
    }
  }

  Future getMealDetails({var ID}) async {
    try {
      isLoading(true);
      print(isLoading);
      var mealDetails =
          // await RemoteServices.getMealDetails(
          //     access_token: '32|B7QogsoOIOqiuUOf0OUVhUqpSkqeAXLxbpe83fmk',
          //     mealID: '1');
          await RemoteServices.getMealDetails(access_token: token, mealID: ID);
      mealDetailsData.value = mealDetails;
      print("21212--------");
      print(mealDetailsData.value);
    } catch (e) {
      print('e..$e');
    } finally {
      isLoading(false);
    }
  }
}
