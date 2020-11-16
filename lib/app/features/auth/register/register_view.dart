import 'package:flutter/material.dart';
import 'package:world_of_beer/app/common/error_helper.dart';
import 'package:world_of_beer/app/common/platform_svg.dart';
import 'package:world_of_beer/app/common/validation.dart';
import 'package:get/get.dart';

import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                SizedBox(height: 16,),
                Obx(() {
                  final res = controller.resRegister.value;
                  if (res?.isError() == true) {
                    final error = res.error;
                    return Text("Error: ${errorTextUi(error)}",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.red)
                    ).marginOnly(bottom: 8);
                  }
                  return Container();
                }),
                Obx(() {
                  if (controller.resRegister.value?.isLoading() == true) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return RaisedButton(
                      child: Text("Register"),
                      onPressed: () {
                        if(_formKey.currentState.validate()) {
                          controller.register();
                        }
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
