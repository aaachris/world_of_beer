import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_of_beer/app/common/transparent_image.dart';
import 'package:world_of_beer/app/features/detail/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Obx(() {
        return Text(controller.resBeer?.value?.data?.name ?? "");
      }),
    ), body: Obx(() {
      final res = controller.resBeer.value;
      if (res.isLoading()) return Center(child: CircularProgressIndicator());
      if (res.isError()) return Center(child: Text("Error: ${res.error}").paddingAll(16));

      final beer = res.data;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeInImage.memoryNetwork(
                image: beer.imageUrl ?? "",
                placeholder: kTransparentImage,
                height: 150,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                beer.tagline,
                style: Theme.of(context).textTheme.subtitle1.copyWith(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "since ${beer.firstBrewed}",
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                beer.description,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 20,
                    color: Colors.black87,
                  ).marginOnly(right: 4),
                  Text(
                    "Food paring:",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  ),
                ],
              ).marginOnly(bottom: 4),
              ...beer.foodPairing.map((paring) {
                return Text(
                  paring,
                  style: Theme.of(context).textTheme.bodyText1,
                );
              }),
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Icon(
                    Icons.info,
                    size: 20,
                    color: Colors.black87,
                  ).marginOnly(right: 4),
                  Text(
                    "Tips:",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  ),
                ],
              ).marginOnly(bottom: 4),
              Text(
                beer?.brewersTips ?? "",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      );
    }));
  }
}
