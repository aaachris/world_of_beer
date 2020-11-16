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
        body: Obx(() {
          final res = controller.resBeers.value;
          if (res.isLoading()) return Center(child: CircularProgressIndicator());
          if (res.isError()) return Center(child: Text("Error: ${res.error}").paddingAll(16));

          final itemCount = res.data.length - 1;
          return ListView.builder(
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) {
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
              });
        }));
  }
}
