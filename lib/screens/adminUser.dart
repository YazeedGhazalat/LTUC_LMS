import 'package:citycafe_app/components/delete.dart';
import 'package:citycafe_app/components/update.dart';
import 'package:citycafe_app/screens/login_screen.dart';
import 'package:citycafe_app/widgets/alertAddPage.dart';
import 'package:citycafe_app/widgets/alertUpdate.dart';
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

    return Scaffold(
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
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          onPressed: () async {
            signOut();
            final GoogleSignInAccount? googleUser =
                await GoogleSignIn().signOut();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("logout successfully")));
          },
          icon: Icon(Icons.logout),
        ),
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
        children: <Widget>[
          edit_button(
            ID: ID,
            stdID: stdID,
            stdName: stdName,
          ),
          delete_button(
            ID: ID,
            stdID: stdID,
            stdName: stdName,
          ),
        ],
      ),
      isThreeLine: true,
      title: Text("$stdName"),
      subtitle: Text("$stdID"),
    );
  }
}
