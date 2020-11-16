import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_of_beer/app/common/transparent_image.dart';
import 'package:world_of_beer/app/features/auth/auth_controller.dart';
import 'package:world_of_beer/app/features/home/home_controller.dart';
import 'package:world_of_beer/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beers'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () {
              AuthController.to.onSignOut();
            },
          )
        ],
      ),
      body: Center(
        child: Obx(() {
          final res = controller.resBeers.value;
          if (res.isLoading()) return Center(child: CircularProgressIndicator());
          if (res.isError()) return Center(child: Text("Error: ${res.error}").paddingAll(16));

          final itemCount = res.data.length - 1;
          final isLoadingMore = controller.isLoadingMore.value;
          Fimber.i("itemCount: $itemCount isLoadingMore: $isLoadingMore");

          return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) => controller.handleScrollUpdate(scrollInfo),
              child: ListView.builder(
                  itemCount: itemCount + (isLoadingMore ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= itemCount) {
                      return Container(
                        height: 64,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final beer = res.data[index];
                    return ListTile(
                      onTap: () {
                        Get.toNamed("${AppPages.DETAIL}/${beer.id}");
                      },
                      leading: FadeInImage.memoryNetwork(
                        image: beer.imageUrl ?? "",
                        placeholder: kTransparentImage,
                        fit: BoxFit.contain,
                        width: 32,
                      ),
                      title: Text(beer.name),
                      subtitle: Text(beer.tagline),
                      trailing: Text(
                        beer.abv.toPrecision(1).toString() + "%",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  }));
        }),
      ),
    );
  }
}
