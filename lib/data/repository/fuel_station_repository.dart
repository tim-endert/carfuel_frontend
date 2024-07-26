import 'package:carfuel_frontend/assets/constants.dart' as constants;
import 'package:carfuel_frontend/data/models/fuel_station.dart';
import 'package:carfuel_frontend/data/provider/data_provider.dart';
import 'package:carfuel_frontend/utils/data_transformers.dart';

class FuelStationRepository {
  DataProvider provider = DataProvider();

  Future<List<FuelStation>> fetchFuelStations() async {
    try {
      final apiResponse =
          await DataProvider.getRequest(endpoint: "${constants.HOST}/stations");

      if (apiResponse.statusCode == 200) {
        List<FuelStation> stations = List<FuelStation>.from(
            apiResponse.data.map((model) => FuelStation.fromJson(model)));

        return stations;
      }

      throw "Error loading stations";
    } catch (e) {
      rethrow;
    }
  }

  createFuelStation(
    Map<String, dynamic> stationData,
  ) async {
    final transformedStationData =
        DataTransformers.transformStationFormData(stationData);

    try {
      final apiResponse = await DataProvider.postRequest(
        endpoint: "${constants.HOST}/stations",
        data: transformedStationData,
      );

      if (apiResponse.statusCode == 200) {
        return;
      }

      throw "Error creating station";
    } catch (e) {
      rethrow;
    }
  }

  removeFuelStation(int stationId) async {
    try {
      final apiResponse = await DataProvider.deleteRequest(
        endpoint: "${constants.HOST}/stations/$stationId",
      );

      if (apiResponse.statusCode == 200) {
        return;
      }

      throw "Error removing station";
    } catch (e) {
      rethrow;
    }
  }

  updateFuelStation(
    int stationId,
    Map<String, dynamic> stationData,
  ) async {
    try {
      final transformedStationData =
          DataTransformers.transformStationFormData(stationData);

      final apiResponse = await DataProvider.updateRequest(
          endpoint: "${constants.HOST}/stations/$stationId",
          data: transformedStationData);

      if (apiResponse.statusCode == 200) {
        return;
      }

      throw "Error updating station";
    } catch (e) {
      rethrow;
    }
  }
}
