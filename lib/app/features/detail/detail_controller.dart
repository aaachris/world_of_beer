import 'package:get/get.dart';

class DetailController extends GetxController {
  final beerId = 0.obs;

  @override
  void onInit() {
    super.onInit();

    int id = int.tryParse(Get.parameters["id"]);
    beerId.value = id;
  }
}
