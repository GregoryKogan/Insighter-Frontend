import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:insighter/api/geo_objects/object_data.dart';
import 'package:insighter/state_controllers/location_controller.dart';
import 'package:insighter/widgets/loading_widgets/loading_circle.dart';

class NearbyObject extends StatefulWidget {
  const NearbyObject({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<NearbyObject> createState() => _NearbyObjectState();
}

class _NearbyObjectState extends State<NearbyObject> {
  final locationController = Get.put(LocationController());
  late Future<Map<String, dynamic>> objectData;

  @override
  void initState() {
    super.initState();
    ObjectDataService objectDataService = ObjectDataService();
    objectData = objectDataService.getObjectData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: objectData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LoadingCircle();
        return SizedBox(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: snapshot.data!['image'] != null
                    ? Image.network(snapshot.data!['image'])
                    : const Icon(Icons.image),
              ),
              Text(snapshot.data!['category']),
              Text(snapshot.data!['name_ru']),
              Text(snapshot.data!['meta']['wiki']['wikipedia']),
              Text(
                  'Distance: ${Geolocator.distanceBetween(locationController.latitude.value, locationController.longitude.value, snapshot.data!['latitude'], snapshot.data!['longitude']).round()}m'),
            ],
          ),
        );
      },
    );
  }
}
