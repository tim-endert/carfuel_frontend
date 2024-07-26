import 'package:carfuel_frontend/bloc/fuel_station_overview_bloc/fuel_station_overview_bloc.dart';
import 'package:carfuel_frontend/presentation/screens/fuel_detail.dart';
import 'package:carfuel_frontend/presentation/screens/fuel_station_editor.dart';
import 'package:carfuel_frontend/presentation/widgets/custom_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' show LatLng;

class FuelMapScreen extends StatelessWidget {
  const FuelMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CarFuel"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FuelStationEditor(),
              ),
            ),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<FuelStationOverviewBloc, FuelStationOverviewState>(
        builder: (context, state) {
          switch (state.status) {
            case FuelStationStatus.loading:
            case FuelStationStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case FuelStationStatus.loaded:
              return CustomMap(
                markers: state.fuelStations
                    .map(
                      (station) => Marker(
                        point: LatLng(station.latitude, station.longitude),
                        width: 46,
                        height: 46,
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FuelDetailScreen(station: station),
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Icon(
                              Icons.ev_station_outlined,
                              color: Theme.of(context).indicatorColor,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            case FuelStationStatus.failure:
              return Center(
                  child: Text(
                "Unfortunately, we have problems accessing the server. ${state.errorMessage}",
              ));
          }
        },
      ),
    );
  }
}
