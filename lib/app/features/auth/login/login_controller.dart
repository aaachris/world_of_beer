
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:world_of_beer/app/features/auth/auth_controller.dart';
import 'package:world_of_beer/app/network/api_client.dart';
import 'package:world_of_beer/app/network/models/post_login_payload.dart';
import 'package:world_of_beer/app/network/models/post_login_response.dart';
import 'package:world_of_beer/app/network/models/resource.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final resLogin = Rx<Resource<PostLoginResponse>>();
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void onInit() {
    emailController = TextEditingController(text: kReleaseMode ? null : "test@test.com");
    passwordController = TextEditingController(text: kReleaseMode ? null : "testtest");
    super.onInit();
  }

  @override
  void onClose() {
    emailController?.dispose();
    passwordController?.dispose();
    super.onClose();
  }

  login(){
    ApiClient client = Get.find();
    resLogin.value = Resource.loading();

    final payload = PostLoginPayload()
      ..username = emailController.text
      ..password = passwordController.text;

    Fimber.i("login payload $payload");

    client.login(payload).then((value) {
      resLogin.value = Resource.success(value);
      AuthController.to.onSignInDone(value);
    }).catchError((onError){
      resLogin.value = Resource.error(onError);
    });
  }


}
