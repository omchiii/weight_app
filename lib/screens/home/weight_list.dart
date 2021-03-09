import "package:flutter/material.dart";
import 'package:flutter_weight_app/screens/home/weight_tile.dart';
import 'package:flutter_weight_app/services/database.dart';
import 'package:flutter_weight_app/shared/loading.dart';

class WeightList extends StatefulWidget {
  @override
  _WeightListState createState() => _WeightListState();
}

class _WeightListState extends State<WeightList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().weights,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text("Something went wrong"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.active) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return WeightTile(weight: snapshot.data[index]);
            },
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        return Loading();
      },
    );
  }
}
