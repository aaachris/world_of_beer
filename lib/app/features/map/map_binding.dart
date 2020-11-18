import 'package:get/get.dart';
import 'package:world_of_beer/app/features/home/home_controller.dart';

import 'map_controller.dart';


class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(
      () => MapController(),
    );
  }
}
