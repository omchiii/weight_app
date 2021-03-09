import 'package:flutter/material.dart';
import 'package:flutter_weight_app/services/database.dart';

class WeightForm extends StatefulWidget {
  @override
  _WeightFormState createState() => _WeightFormState();
}

class _WeightFormState extends State<WeightForm> {
  final _formKey = GlobalKey<FormFieldState>();

  final _formFocusNode = FocusNode();

  final _formController = TextEditingController();

  final _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: [
            Text(
              "Add a weight.",
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
                  _db.addWeightItem(weight);
                }
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
