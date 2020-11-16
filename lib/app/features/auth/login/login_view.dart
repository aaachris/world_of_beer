import 'package:flutter/material.dart';
import 'package:world_of_beer/app/common/error_helper.dart';
import 'package:world_of_beer/app/common/platform_svg.dart';
import 'package:world_of_beer/app/common/validation.dart';
import 'package:world_of_beer/app/routes/app_pages.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PlatformSvg.asset("assets/icons/toast.svg", height: 80, width: 80).marginAll(16),
                TextFormField(
                  controller: controller.emailController,
                  validator: validateEmail,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: controller.passwordController,
                  validator: validatePassword,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                SizedBox(
                  height: 16,
                ),
                Obx(() {
                  final res = controller.resLogin.value;
                  if (res?.isError() == true) {
                    final error = res.error;
                    return Text("Error: ${errorTextUi(error)}",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.red)
                    ).marginOnly(bottom: 8);
                  }
                  return Container();
                }),
                Obx(() {
                  if (controller.resLogin.value?.isLoading() == true) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return RaisedButton(
                      child: Text("Login"),
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          controller.login();
                        }
                      },
                    );
                  }
                }),
                Divider().marginSymmetric(vertical: 16),
                OutlineButton(
                  child: Text("Register"),
                  onPressed: () {
                    Get.toNamed(AppPages.REGISTER);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
