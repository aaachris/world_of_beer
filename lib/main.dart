import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_of_beer/app/network/api_client.dart';
import 'package:world_of_beer/app/routes/app_pages.dart';

void main() {
  initFimber();
  initDio();
  runApp(MyApp());
}

void initFimber(){
  if(kDebugMode) {
    Fimber.plantTree(DebugTree());
  }
}

void initDio() {
  Fimber.i("initDio");
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(responseBody: true));
  Get.put(ApiClient(dio), permanent: true);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "Beers",
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
