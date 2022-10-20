import 'package:citycafe_app/screens/admin/tab1.dart';
import 'package:citycafe_app/screens/admin/tab2.dart';
import 'package:citycafe_app/screens/admin/tab3.dart';
import 'package:citycafe_app/screens/login_signUp/login_screen.dart';
import 'package:citycafe_app/widgets/alertPages/alertAddPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _firestore = FirebaseFirestore.instance;
late User signInUser; //this give us the email

class adminPage extends StatefulWidget {
  const adminPage({super.key});
  static const String screenRoute = "adminPage";
  @override
  State<adminPage> createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {
  final _auth = FirebaseAuth.instance;
  @override
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

  Widget build(BuildContext context) {
    Future signOut() async {
      var result = await FirebaseAuth.instance.signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
      Navigator.pushReplacementNamed(context, Login_screen.screenRoute);
      return result;
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          elevation: 20,
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: ((context) {
                  return AlertPage(); //Create item
                }));
          },
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepOrange,
          actions: [
            IconButton(
              onPressed: () async {
                signOut();
                final GoogleSignInAccount? googleUser =
                    await GoogleSignIn().signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("logout successfully")));
              },
              icon: Icon(Icons.logout),
            ),
          ],
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.list),
              text: "Student List",
            ),
            Tab(
              icon: Icon(Icons.list),
              text: "Admin List",
            ),
            Tab(
              icon: Icon(Icons.person_pin_outlined),
              text: "Profile",
            ),
          ]),
        ),
        body: SafeArea(
          child: TabBarView(children: [straem1(), Stream2(), profilePage()]),
        ),
      ),
    );
  }
}
