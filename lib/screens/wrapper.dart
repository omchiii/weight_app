import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_weight_app/models/AnonUser.dart';
import 'package:flutter_weight_app/screens/authenticate/sign_in.dart';
import 'package:flutter_weight_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AnonUser>(context);

    if (user == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
