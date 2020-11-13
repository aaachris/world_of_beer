import 'package:get/get.dart';
import 'package:world_of_beer/app/features/home/home_binding.dart';
import 'package:world_of_beer/app/features/home/home_view.dart';

class AppPages {
  static const HOME = "/";

  static final routes = [
    GetPage(
      name: HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
