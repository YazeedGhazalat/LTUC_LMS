import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String screenRoute = "Home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    signOut() {
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            signOut();
          },
          icon: Icon(Icons.logout),
        ),
      ),
      body: Container(),
    );
  }
}
