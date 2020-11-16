
import 'package:fimber/fimber.dart';
import 'package:world_of_beer/app/network/models/post_login_response.dart';
import 'package:world_of_beer/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final isLoggedIn = true.obs;
  String _accessToken;

  @override
  onInit() async {
    Fimber.i("onInit ${isLoggedIn.value}");
    ever(isLoggedIn, _handleAuthChanged);

    _accessToken = _prefs.getString("accessToken");
    Fimber.i("saved accesstoken: $_accessToken");

    isLoggedIn.value = _accessToken != null;
    super.onInit();
  }

  _handleAuthChanged(isLoggedIn) {
    Fimber.i("handleAuthChanged $isLoggedIn");
    if (isLoggedIn == false) {
      _handleChangeRoute(AppPages.LOGIN);
    } else {
      _handleChangeRoute(AppPages.HOME);
    }
  }
  
  _handleChangeRoute(String route){
    if(Get.currentRoute != route){
      Get.offAllNamed(route);
    }
  }

  String getAccessToken() {
    return _accessToken;
  }

  onSignOut() async {
    Fimber.i("onSignOut");
    _accessToken = null;
    await _prefs.remove("accessToken");
    isLoggedIn.value = false;
  }

  onSignInDone(PostLoginResponse response) async {
    Fimber.i("onSignInDone $response");
    _accessToken = response.accessToken;
    await _prefs.setString("accessToken", _accessToken);
    isLoggedIn.value = true;
  }



}
