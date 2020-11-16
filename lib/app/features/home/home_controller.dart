import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_of_beer/app/network/api_client.dart';
import 'package:world_of_beer/app/network/models/beer_model.dart';
import 'package:world_of_beer/app/network/models/resource.dart';

class HomeController extends GetxController {
  static const int _pageSize = 20;

  final resBeers = Rx<Resource<List<Beer>>>();
  final isLoadingMore = false.obs;
  var _allBeersLoaded = false;
  int _currPage = 1;

  @override
  void onInit() {
    super.onInit();
    _loadBeers();
  }

  void _loadBeers() {
    ApiClient client = Get.find();
    _allBeersLoaded = false;
    isLoadingMore.value = false;
    resBeers.value = Resource.loading();

    client.getBeers(_pageSize).then((value) {
      resBeers.value = Resource.success(value);
    }).catchError((onError) {
      resBeers.value = Resource.error(onError);
    });
  }

  void _loadMore() {
    isLoadingMore.value = true;
    ApiClient client = Get.find();

    client.getBeers(_pageSize, page: _currPage).then((value) {
      Fimber.i("loadMore success page: $_currPage count: ${value.length}");
      _currPage++;
      _allBeersLoaded = value.length != _pageSize;
      isLoadingMore.value = false;
      resBeers.value = Resource.success(resBeers.value.data..addAll(value));
    }).catchError((onError) {
      Fimber.i("loadMore error $onError");
      isLoadingMore.value = false;
    });
  }

  bool handleScrollUpdate(ScrollNotification scrollInfo) {
    if (!_allBeersLoaded && !isLoadingMore.value && scrollInfo.metrics.extentAfter < 50) {
      _loadMore();
    }
    return true;
  }
}
