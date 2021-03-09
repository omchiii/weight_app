import 'package:flutter/material.dart';
import 'package:flutter_weight_app/services/auth.dart';
import 'package:flutter_weight_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: loading
            ? Loading()
            : Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 20.0,
                  ),
                  child: TextButton.icon(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(2.0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      _auth.signInAnon();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign In Anonymously"),
                  ),
                ),
              ));
  }
}
