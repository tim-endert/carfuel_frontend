class DataTransformers {
  static Map<String, dynamic> transformStationFormData(
      Map<String, dynamic> formData) {
    Map<String, dynamic> transformedMap = {};
    List<Map<String, dynamic>> pumpsList = [];
    Map<int, Map<String, dynamic>> tempPumps = {};

    formData.forEach((key, value) {
      if (key.startsWith('pumps[')) {
        final match = RegExp(r'pumps\[(\d+)\](.+)').firstMatch(key);
        if (match != null) {
          final index = int.parse(match.group(1)!);
          final attribute = match.group(2)!;

          if (!tempPumps.containsKey(index)) {
            tempPumps[index] = {};
          }
          tempPumps[index]![attribute] = value;
        }
      } else {
        transformedMap[key] = value;
      }
    });

    pumpsList = tempPumps.values.toList();
    transformedMap['pumps'] = pumpsList;

    return transformedMap;
  }
}
