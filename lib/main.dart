import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_of_beer/app/network/api_client.dart';
import 'package:world_of_beer/app/routes/app_pages.dart';

import 'app/features/auth/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initFimber();
  await initSharedPrefs();
  initDio();
  runApp(MyApp());
}

Future<void> initSharedPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
}

void initFimber(){
  if(kDebugMode) {
    Fimber.plantTree(DebugTree());
  }
}

void initDio() {
  Fimber.i("initDio");
  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
    final accessToken = AuthController.to.getAccessToken();
    if(accessToken != null){
      options.headers["Authorization"] = "Bearer $accessToken";
    }
    return options;
  }, onError: (DioError error){
    if ([401, 400].contains(error.response?.statusCode)) {
      AuthController.to.onSignOut();
    }
  }));
  dio.interceptors.add(LogInterceptor(responseBody: true));
  Get.put(ApiClient(dio), permanent: true);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "Beers",
        initialBinding: BindingsBuilder(() async {
          Get.put(AuthController(), permanent: true);
        }),
        initialRoute: AppPages.HOME,
        getPages: AppPages.routes,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            buttonTheme: ButtonThemeData(
                buttonColor: Colors.blue,
                textTheme: ButtonTextTheme.primary
            )
        )
    );
  }
}
