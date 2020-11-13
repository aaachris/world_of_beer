import 'package:get/get.dart';
import 'package:world_of_beer/app/network/api_client.dart';
import 'package:world_of_beer/app/network/models/beer_model.dart';
import 'package:world_of_beer/app/network/models/resource.dart';

class HomeController extends GetxController {
  static const int _pageSize = 20;

  final resBeers = Rx<Resource<List<Beer>>>();

  @override
  void onInit() {
    super.onInit();
    _loadBeers();
  }

  void _loadBeers() {
    ApiClient client = Get.find();
    resBeers.value = Resource.loading();

    client.getBeers(_pageSize).then((value) {
      resBeers.value = Resource.success(value);
    }).catchError((onError) {
      resBeers.value = Resource.error(onError);
    });
  }
}
