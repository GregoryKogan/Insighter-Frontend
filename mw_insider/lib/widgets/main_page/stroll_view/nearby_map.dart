import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:mw_insider/geolocation/geofencing.dart';
import 'package:mw_insider/state_controllers/location_controller.dart';
import 'package:mw_insider/theming/themes.dart';
import 'package:mw_insider/widgets/loading_widgets/loading_circle.dart';

class NearbyMap extends StatefulWidget {
  const NearbyMap({Key? key}) : super(key: key);

  @override
  State<NearbyMap> createState() => _NearbyMapState();
}

class _NearbyMapState extends State<NearbyMap> {
  final locationController = Get.put(LocationController());
  final MapController _mapController = MapController();
  final double defaultZoom = 14.5;
  double initLat = 0;
  double initLon = 0;
  bool _isTracking = false;
  bool _isLoading = true;
  List<Marker> _markers = [];

  StreamSubscription<double>? _posSub;
  StreamSubscription<bool>? _trackSub;

  void setup() async {
    setState(() {
      _posSub = locationController.latitude.listen((_) {
        _mapController.move(
            LatLng(locationController.latitude.value,
                locationController.longitude.value),
            _mapController.zoom);
        _updateMarkers();
      });

      _trackSub = locationController.isTracking.listen((_) {
        setState(() {
          _isTracking = locationController.isTracking.value;
          initLat = locationController.latitude.value;
          initLon = locationController.longitude.value;
          _updateMarkers();

          if (_isTracking) {
            _mapController.move(
                LatLng(locationController.latitude.value,
                    locationController.longitude.value),
                _mapController.zoom);
          }
        });
      });

      _isTracking = locationController.isTracking.value;
      initLat = locationController.latitude.value;
      initLon = locationController.longitude.value;
      _updateMarkers();
      _isLoading = false;
    });

    Future.delayed(
        const Duration(seconds: 1), () => GeofencingService().fetchLocation());
  }

  void _updateMarkers() {
    List<Marker> markers = [];
    for (final geoObject in locationController.nearbyObjects) {
      markers.add(
        Marker(
          point: LatLng(geoObject['lat'], geoObject['lon']),
          builder: (ctx) => Icon(Icons.location_searching,
              color: context.theme.extension<Palette>()!.orange),
        ),
      );
    }
    if (markers != _markers) {
      setState(() {
        _markers = markers;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  void dispose() {
    super.dispose();
    if (_posSub != null) {
      _posSub!.cancel();
    }
    if (_trackSub != null) {
      _trackSub!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: LoadingCircle())
        : FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(initLat, initLon),
              zoom: defaultZoom,
              maxZoom: 19.0,
              minZoom: 5.0,
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                  backgroundColor:
                      context.theme.extension<Palette>()!.background!,
                  maxZoom: 19.0,
                  minZoom: 5.0,
                  tilesContainerBuilder:
                      Get.isDarkMode ? darkModeTilesContainerBuilder : null,
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  attributionBuilder: (_) {
                    return const Text("© OpenStreetMap contributors",
                        style: TextStyle(
                          fontSize: 12,
                        ));
                  },
                ),
              ),
              MarkerClusterLayerWidget(
                options: MarkerClusterLayerOptions(
                  maxClusterRadius: 50,
                  fitBoundsOptions: const FitBoundsOptions(
                    padding: EdgeInsets.all(50),
                  ),
                  markers: _markers,
                  polygonOptions: const PolygonOptions(
                    color: Color(0x00000000),
                  ),
                  builder: (context, markers) {
                    return Icon(
                      Icons.gps_fixed_outlined,
                      color: context.theme.extension<Palette>()!.orange,
                      size: 35,
                    );
                    // return Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(100)),
                    //       color: context.theme.extension<Palette>()!.orange),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8),
                    //     child: Text(markers.length.toString()),
                    //   ),
                    // );
                  },
                ),
              ),
              // MarkerLayerWidget(
              //   options: MarkerLayerOptions(markers: _markers),
              // ),
              if (_isTracking)
                LocationMarkerLayerWidget(
                  options: LocationMarkerLayerOptions(
                    positionStream: const LocationMarkerDataStreamFactory()
                        .geolocatorPositionStream(
                      stream: locationController.locationStream.value,
                    ),
                    marker: DefaultLocationMarker(
                      color: context.theme.extension<Palette>()!.cyan!,
                    ),
                    accuracyCircleColor: context.theme
                        .extension<Palette>()!
                        .cyan!
                        .withOpacity(0.1),
                    headingSectorColor: context.theme
                        .extension<Palette>()!
                        .cyan!
                        .withOpacity(0.8),
                    headingSectorRadius: 60,
                    markerAnimationDuration:
                        const Duration(milliseconds: 500), // disable animation
                  ),
                ),
            ],
          );
  }
}
