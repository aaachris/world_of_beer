import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_of_beer/app/common/transparent_image.dart';
import 'package:world_of_beer/app/features/detail/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return Text("Beer ${controller.beerId?.value ?? ""}");
          }),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeInImage.memoryNetwork(
                  image: "https://st2.depositphotos.com/1050070/12363/i/950/depositphotos_123633312-stock-photo-bottle-of-corona-extra-beer.jpg",
                  placeholder: kTransparentImage,
                  height: 150,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Tagline",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "since 1964",
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ));
  }
}
