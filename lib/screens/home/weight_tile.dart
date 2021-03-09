import 'package:flutter/material.dart';
import 'package:flutter_weight_app/models/Weight.dart';
import 'package:flutter_weight_app/screens/home/weight_settings.dart';
import 'package:flutter_weight_app/services/database.dart';

class WeightTile extends StatefulWidget {
  final Weight weight;

  WeightTile({this.weight});

  @override
  _WeightTileState createState() => _WeightTileState();
}

class _WeightTileState extends State<WeightTile> {
  final _db = DatabaseService();

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(Weight weight) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
              child: WeightSettings(
                weight: weight,
              ),
            );
          });
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          onTap: () => _showSettingsPanel(widget.weight),
          title: Text((widget.weight.weight == widget.weight.weight.truncate()
                  ? widget.weight.weight.truncate().toString()
                  : widget.weight.weight.toString()) +
              " kg"),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _db.deleteWeightItem(widget.weight.id),
          ),
        ),
      ),
    );
  }
}
