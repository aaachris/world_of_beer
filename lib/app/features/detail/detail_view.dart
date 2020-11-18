import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:world_of_beer/app/common/platform_svg.dart';
import 'package:world_of_beer/app/common/transparent_image.dart';
import 'package:world_of_beer/app/features/detail/detail_controller.dart';
import 'package:world_of_beer/app/routes/app_pages.dart';

class DetailView extends GetView<DetailController> {
  int drinkCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(controller.resBeer?.value?.data?.name ?? "");
        }),
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            drinkCount++;
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Beer count: $drinkCount"),
            ));
          },
          child: PlatformSvg.asset("assets/icons/toast.svg").marginAll(12),
        );
      }),
      body: Obx(() {
        final res = controller.resBeer.value;
        if (res.isLoading()) return Center(child: CircularProgressIndicator());
        if (res.isError()) return Center(child: Text("Error: ${res.error}").paddingAll(16));
        final beer = res.data;
        return SingleChildScrollView(
          child: SafeArea(
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
                  SizedBox(height: 32,),
                  OutlineButton(
                    child: Text("Show on Map"),
                    onPressed: (){
                      Get.toNamed(AppPages.MAP);
                    },
                  ),
                  SizedBox(height: 64,),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
