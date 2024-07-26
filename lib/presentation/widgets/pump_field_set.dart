import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PumpFieldSet extends StatelessWidget {
  const PumpFieldSet({
    super.key,
    required this.fieldId,
    this.price,
    this.available,
    this.type,
  });
  final int fieldId;
  final String? type;
  final String? price;
  final bool? available;

  @override
  Widget build(BuildContext context) {
    var fuelTypeFieldName = "pumps[$fieldId]fuelType";
    var fuelTypeKey = ValueKey(fuelTypeFieldName);

    var fuelPriceFieldName = "pumps[$fieldId]price";
    var fuelPriceKey = ValueKey(fuelPriceFieldName);

    var fuelAvailabilityFieldName = "pumps[$fieldId]available";
    var fuelAvailabilityKey = ValueKey(fuelAvailabilityFieldName);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          FormBuilderTextField(
            name: fuelTypeFieldName,
            key: fuelTypeKey,
            initialValue: type,
            validator: FormBuilderValidators.minLength(1),
            decoration: const InputDecoration(
              label: Text('Fuel Type'),
            ),
          ),
          FormBuilderTextField(
            name: fuelPriceFieldName,
            key: fuelPriceKey,
            initialValue: price,
            validator: FormBuilderValidators.numeric(),
            decoration: const InputDecoration(
              label: Text('Price'),
            ),
          ),
          FormBuilderSwitch(
            name: fuelAvailabilityFieldName,
            key: fuelAvailabilityKey,
            initialValue: available ?? false,
            title: const Text("Available"),
          ),
        ],
      ),
    );
  }
}
