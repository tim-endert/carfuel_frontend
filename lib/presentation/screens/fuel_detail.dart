import 'package:carfuel_frontend/bloc/fuel_station_detail/fuel_station_detail_bloc.dart';
import 'package:carfuel_frontend/bloc/fuel_station_overview_bloc/fuel_station_overview_bloc.dart';
import 'package:carfuel_frontend/data/models/fuel_station.dart';
import 'package:carfuel_frontend/data/models/station_pump.dart';
import 'package:carfuel_frontend/presentation/screens/fuel_station_editor.dart';
import 'package:carfuel_frontend/presentation/widgets/custom_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' show LatLng;

class FuelDetailScreen extends StatelessWidget {
  final FuelStation station;
  const FuelDetailScreen({required this.station, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FuelStationDetailBloc, FuelStationDetailState>(
        listener: (context, state) {
          if (state is FuelStationDetailLoading) {
            showDialog(
              context: context,
              builder: (BuildContext context) => const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (state is FuelStationDetailFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Operation Failed: ${state.errorMessage}'),
            ));
          }

          if (state is FuelStationDetailSuccess) {
            context.read<FuelStationOverviewBloc>().add(FetchFuelStations());
            Navigator.popUntil(context, ModalRoute.withName("/"));

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Successfully created'),
            ));
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(station.name),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit station',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FuelStationEditor(
                          station: station,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Delete',
                    onPressed: () => context.read<FuelStationDetailBloc>().add(
                          FuelStationRemovalRequested(station.id),
                        ),
                  ),
                ]),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: CustomMap(
                        initialCenter:
                            LatLng(station.latitude, station.longitude),
                        isInteractive: false,
                        markers: [
                          Marker(
                            point: LatLng(station.latitude, station.longitude),
                            width: 46,
                            height: 46,
                            child: CircleAvatar(
                              backgroundColor: Colors.green[700],
                              child: Icon(
                                Icons.ev_station_outlined,
                                color: Colors.green[100],
                              ),
                            ),
                          ),
                        ],
                      )),
                  Text("${station.address}, ${station.city}"),
                ],
              ),
            ),
            station.pumps != null
                ? SliverList.builder(
                    itemCount: station.pumps!.length,
                    itemBuilder: (context, index) {
                      StationPump pump = station.pumps![index];

                      return ListTile(
                        title: Text(pump.fuelType),
                        subtitle: Text("CHF ${pump.price.toString()}"),
                        trailing: CircleAvatar(
                          radius: 8,
                          backgroundColor: pump.available
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).disabledColor,
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
