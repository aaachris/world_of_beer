import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:world_of_beer/app/network/api_client.dart';
import 'package:world_of_beer/app/network/models/beer_model.dart';
import 'package:world_of_beer/app/network/models/resource.dart';

class MapController extends GetxController {
  final markers = Rx<Set<Marker>>(Set());
  final initialPosition = CameraPosition(target: LatLng(48.27200876492324, 14.243952110409737), zoom: 17);

  GoogleMapController _controller;
  final List<Marker> _markerList = [];

  @override
  void onInit() {
    super.onInit();

    final Marker marker = Marker(
      markerId: MarkerId("rosenbauer"),
      position: initialPosition.target,
      infoWindow: InfoWindow(title: "Rosenbauer Plant I"),
    );

    _markerList.add(marker);
    _updateMarkers();
  }

  void _updateMarkers() {
    markers.value = Set.of(_markerList);
  }

  void addMarker(LatLng latLng) {
    Fimber.i("addMarker $latLng");
    _markerList.add(createMarker(latLng));
    _updateMarkers();
    _controller?.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  void deleteMarker(LatLng latLng) {
    Fimber.i("deleteMarker $latLng");
    _markerList.removeWhere((element) => element.position == latLng);
    _updateMarkers();
  }

  Marker createMarker(LatLng latLng) {
    final markerId = MarkerId("${latLng.latitude}-${latLng.longitude}");
    return Marker(
      markerId: markerId,
      position: latLng,
      infoWindow: InfoWindow(
          title: "Marker",
          onTap: () {
            deleteMarker(latLng);
          }),
    );
  }

  void setMapController(GoogleMapController mapController) {
    _controller = mapController;
  }
}
