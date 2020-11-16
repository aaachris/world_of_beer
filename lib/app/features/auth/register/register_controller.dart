
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:world_of_beer/app/features/auth/auth_controller.dart';
import 'package:world_of_beer/app/network/api_client.dart';
import 'package:world_of_beer/app/network/models/post_login_response.dart';
import 'package:world_of_beer/app/network/models/post_register_payload.dart';
import 'package:world_of_beer/app/network/models/resource.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  final resRegister = Rx<Resource<PostLoginResponse>>();
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

  register(){
    ApiClient client = Get.find();
    resRegister.value = Resource.loading();

    final payload = PostRegisterPayload()
      ..username = emailController.text
      ..password = passwordController.text;

    Fimber.i("register payload $payload");

    client.register(payload).then((value) {
      resRegister.value = Resource.success(value);
      AuthController.to.onSignInDone(value);
    }).catchError((onError){
      resRegister.value = Resource.error(onError);
    });
  }


}
