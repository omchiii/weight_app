import 'package:flutter/material.dart';
import 'package:flutter_weight_app/models/Weight.dart';
import 'package:flutter_weight_app/services/database.dart';

class WeightSettings extends StatefulWidget {
  final Weight weight;

  WeightSettings({this.weight});

  @override
  _WeightSettingsState createState() => _WeightSettingsState();
}

class _WeightSettingsState extends State<WeightSettings> {
  final _formKey = GlobalKey<FormFieldState>();

  final _formFocusNode = FocusNode();

  final _formController = TextEditingController();

  final _db = DatabaseService();

  @override
  void initState() {
    super.initState();
    _formController.text = widget.weight.weight.toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _formFocusNode.unfocus();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          child: Wrap(
            children: [
              Text(
                "Edit weight.",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                key: _formKey,
                focusNode: _formFocusNode,
                controller: _formController,
                decoration: InputDecoration(suffixText: "kg"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    value.isEmpty || double.tryParse(value) == null
                        ? "Please enter a number"
                        : null,
              ),
              ElevatedButton(
                onPressed: () {
                  _formController.text =
                      _formController.text.replaceAll(RegExp(","), ".");

                  if (_formKey.currentState.validate()) {
                    double weight = double.parse(_formController.text);
                    _formController.clear();
                    _formFocusNode.unfocus();
                    _db.updateWeightItem(
                        weight, widget.weight.dateTime, widget.weight.id);
                    Navigator.pop(context);
                  }
                },
                child: Icon(Icons.edit),
              )
            ],
          ),
        ),
      ),
    );
  }
}
