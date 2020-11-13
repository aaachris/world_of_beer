import 'package:get/get.dart';
import 'package:world_of_beer/app/features/detail/detail_binding.dart';
import 'package:world_of_beer/app/features/detail/detail_view.dart';
import 'package:world_of_beer/app/features/home/home_binding.dart';
import 'package:world_of_beer/app/features/home/home_view.dart';

class AppPages {
  static const HOME = "/";
  static const DETAIL = "/detail";

  static final routes = [
    GetPage(
      name: HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: "$DETAIL/:id",
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
  ];
}
