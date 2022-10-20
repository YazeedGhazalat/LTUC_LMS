import 'package:citycafe_app/screens/admin/adminUser.dart';
import 'package:citycafe_app/screens/anyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

late User signInUser;

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

  @override
  Widget build(BuildContext context) {
    List adminList = [
      'admin@gmail.com',
      "yazeedabugazal@gmail.com",
      'm.almsedin@gmail.com'
    ];
    if (adminList.contains(signInUser.email))
      return adminPage();
    else
      return AnyUserPage();
  }
}
