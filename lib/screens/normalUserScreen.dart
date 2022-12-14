import 'package:citycafe_app/screens/login_signUp/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _firestore = FirebaseFirestore.instance;
late User signInUser; //this give us the email

class AnyUserPage extends StatefulWidget {
  const AnyUserPage({super.key});
  static const String screenRoute = "AnyPage";
  @override
  State<AnyUserPage> createState() => _AnyUserPageState();
}

class _AnyUserPageState extends State<AnyUserPage> {
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

  Future signOut() async {
    var result = await FirebaseAuth.instance.signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
    Navigator.pushReplacementNamed(context, Login_screen.screenRoute);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            onPressed: () {
              signOut();

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("logout successfully")));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
              // Read or get item from firestore
              stream: FirebaseFirestore.instance
                  .collection("student")
                  .orderBy('stdName', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("there is an error");
                }
                if (snapshot.hasData) {
                  final students = snapshot.data!.docs;
                  List<listWediget> listWedgets = [];
                  for (var student in students) {
                    final stdName = student["stdName"];
                    final stdID = student['stdID'];
                    final id = student['id'];
                    final listwedget = listWediget(
                      stdName: stdName,
                      stdID: stdID,
                      ID: id,
                    );
                    listWedgets.add(listwedget);
                  }
                  return Column(
                    children: listWedgets,
                  );
                }
                return const CircularProgressIndicator.adaptive();
              }),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class listWediget extends StatelessWidget {
  listWediget({
    required this.ID,
    required this.stdID,
    required this.stdName,
    Key? key,
  }) : super(key: key);
  String? stdName;
  String? stdID;
  String? ID;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Wrap(
        spacing: 5, // space between two icons
        children: <Widget>[],
      ),
      isThreeLine: true,
      title: Text("$stdName"),
      subtitle: Text("$stdID"),
    );
  }
}
