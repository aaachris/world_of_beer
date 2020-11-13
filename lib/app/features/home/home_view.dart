import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:world_of_beer/app/features/home/home_controller.dart';
import 'package:world_of_beer/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beers'),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                Get.toNamed("${AppPages.DETAIL}/$index");
              },
              leading: SvgPicture.asset(
                "assets/icons/toast.svg",
                width: 32,
              ),
              title: Text("Beer $index"),
              subtitle: Text("Beer tagline"),
              trailing: Text(
                "5%",
                style: Theme.of(context).textTheme.caption,
              ),
            );
          }),
    );
  }
}
