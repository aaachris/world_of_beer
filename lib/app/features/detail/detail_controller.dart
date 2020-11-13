import 'package:get/get.dart';
import 'package:world_of_beer/app/network/api_client.dart';
import 'package:world_of_beer/app/network/models/beer_model.dart';
import 'package:world_of_beer/app/network/models/resource.dart';

class DetailController extends GetxController {
  final resBeer = Rx<Resource<Beer>>();

  @override
  void onInit() {
    super.onInit();

    int id = int.tryParse(Get.parameters["id"]);
    loadBeer(id);
  }

  void loadBeer(int beerId) {
    ApiClient client = Get.find();
    resBeer.value = Resource.loading();

    client.getBeer(beerId).then((value) {
      resBeer.value = Resource.success(value.first);
    }).catchError((onError) {
      resBeer.value = Resource.error(onError);
    });
  }
}
