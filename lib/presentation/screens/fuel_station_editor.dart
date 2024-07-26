import 'package:carfuel_frontend/bloc/fuel_station_detail/fuel_station_detail_bloc.dart';
import 'package:carfuel_frontend/data/models/fuel_station.dart';
import 'package:carfuel_frontend/presentation/widgets/pump_field_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FuelStationEditor extends StatefulWidget {
  const FuelStationEditor({super.key, this.station});

  final FuelStation? station;

  @override
  State<FuelStationEditor> createState() => _FuelStationEditorState();
}

class _FuelStationEditorState extends State<FuelStationEditor> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<Widget> pumpFields = [];
  var newTextFieldId = 0;

  @override
  void initState() {
    super.initState();
    if (widget.station?.pumps != null) {
      for (var i = 0; i < widget.station!.pumps!.length; i++) {
        var pump = widget.station!.pumps![i];
        pumpFields.add(PumpFieldSet(
          fieldId: newTextFieldId++,
          price: pump.price.toString(),
          available: pump.available,
          type: pump.fuelType,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      clearValueOnUnregister: true,
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(widget.station != null ? "Edit station" : "Create station"),
        ),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 21,
              ),
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'name',
                    initialValue: widget.station?.name,
                    decoration:
                        const InputDecoration(labelText: 'Station Name'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'address',
                    initialValue: widget.station?.address,
                    decoration: const InputDecoration(labelText: 'Address'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'city',
                    initialValue: widget.station?.city,
                    decoration: const InputDecoration(labelText: 'City'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: FormBuilderTextField(
                          name: 'latitude',
                          initialValue: widget.station?.latitude.toString(),
                          decoration: const InputDecoration(labelText: 'Lat'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric()
                          ]),
                        ),
                      ),
                      Flexible(
                        child: FormBuilderTextField(
                          name: 'longitude',
                          initialValue: widget.station?.longitude.toString(),
                          decoration: const InputDecoration(labelText: 'Lng'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric()
                          ]),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Pumps"),
                        IconButton(
                          onPressed: () => setState(
                            () => pumpFields
                                .add(PumpFieldSet(fieldId: newTextFieldId++)),
                          ),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  ...pumpFields
                ],
              ),
            ),
          ),
        ]),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final formData = _formKey.currentState!.value;

                  context.read<FuelStationDetailBloc>().add(
                      widget.station == null
                          ? FuelStationCreateRequested(formData)
                          : FuelStationUpdateRequested(
                              formData, widget.station!.id));
                }
              },
              child: Text(widget.station != null ? "Edit" : "Save"),
            ),
          ),
        ),
      ),
    );
  }
}
