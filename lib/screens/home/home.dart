import 'package:flutter/material.dart';
import 'package:flutter_weight_app/screens/home/weight_form.dart';
import 'package:flutter_weight_app/screens/home/weight_list.dart';
import 'package:flutter_weight_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => _auth.signOut())
        ],
        title: Text(
          "Home",
        ),
      ),
      body: Column(
        children: [
          WeightForm(),
          Expanded(child: WeightList()),
        ],
      ),
    );
  }
}
