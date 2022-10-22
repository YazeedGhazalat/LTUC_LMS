import 'package:citycafe_app/screens/admin/adminUserScreen.dart';
import 'package:citycafe_app/screens/normalUserScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

late User signInUser;
String? AdminRole;

class Home extends StatefulWidget {
  const Home({super.key});
  static const String screenRoute = "Home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signInUser = user;
        print(signInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    List adminList = [
      'admin@gmail.com',
      "yazeedabugazal@gmail.com",
      'm.almsedin@gmail.com',
      "a@gmail.com"
    ];
    List roleList = [
      'Admin',
      "Super Admin",
    ];
    print("**********$AdminRole");
    if (adminList.contains(signInUser.email))
      return adminPage();
    else
      return AnyUserPage();
  }
}
