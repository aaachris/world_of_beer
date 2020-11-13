import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_of_beer/app/routes/app_pages.dart';

void main() {
  initFimber();
  runApp(MyApp());
}

void initFimber(){
  if(kDebugMode) {
    Fimber.plantTree(DebugTree());
  }
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
