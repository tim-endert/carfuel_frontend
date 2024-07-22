import 'package:carfuel_frontend/assets/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CustomMap extends StatelessWidget {
  final bool isInteractive;
  final List<Marker>? markers;
  final LatLng initialCenter;

  const CustomMap({
    super.key,
    this.isInteractive = true,
    this.initialCenter = const LatLng(47.3769, 8.5417),
    this.markers,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        interactionOptions: InteractionOptions(
            flags: isInteractive ? InteractiveFlag.all : InteractiveFlag.none),
        initialZoom: 9.5,
        initialCenter: initialCenter,
      ),
      children: [
        TileLayer(
          urlTemplate: constants.TILE_LAYER_URL,
        ),
        if (markers != null)
          MarkerLayer(
            markers: markers!,
          ),
      ],
    );
  }
}
