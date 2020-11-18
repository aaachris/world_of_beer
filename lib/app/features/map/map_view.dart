import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:world_of_beer/app/common/platform_svg.dart';
import 'package:world_of_beer/app/common/transparent_image.dart';
import 'package:world_of_beer/app/features/detail/detail_controller.dart';
import 'package:world_of_beer/app/features/map/map_controller.dart';

class MapView extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Map"),
        ),
        body: Obx(() {
          return GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: controller.initialPosition,
            mapType: MapType.satellite,
            markers: controller.markers.value,
            onMapCreated: (mapController) {
              controller.setMapController(mapController);
            },
            onLongPress: (latLng) {
              controller.addMarker(latLng);
            },
          );
        }));
  }
}
