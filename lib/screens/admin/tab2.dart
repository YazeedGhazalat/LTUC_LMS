import 'package:citycafe_app/components/deleteAdmin.dart';
import 'package:citycafe_app/components/editAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/my_button.dart';

late User signInUser;

class Stream2 extends StatefulWidget {
  const Stream2({super.key});

  @override
  State<Stream2> createState() => _Stream2State();
}

class _Stream2State extends State<Stream2> {
  final adminControl = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? adminEmail;
  //this give us the admin Email for the name
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
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 320,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onChanged: ((value) {
                  adminEmail = value;
                }),
                controller: adminControl,
                decoration: InputDecoration(
                  hintText: "Admin Email",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Button_Tow(
                child: Icon(Icons.add),
                color: Colors.deepOrange,
                onPressed: (() {
                  print("${adminEmail}");
                  adminControl.clear();

                  try {
                    final docUser =
                        FirebaseFirestore.instance.collection("admin").doc();
                    docUser.set({
                      'id': docUser.id,
                      'adminEmail': adminEmail!.toTitleCase(),
                      'time': FieldValue.serverTimestamp(),
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("added successfully")));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Cannot be null ")));
                  }
                }))
          ],
        ),
        StreamBuilder(
            // Read or get item from firestore
            stream: FirebaseFirestore.instance
                .collection("admin")
                .orderBy('adminEmail', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("there is an error");
              }
              if (snapshot.hasData) {
                final admins = snapshot.data!.docs;
                List<adminListWedget> adminListWedgets = [];
                for (var admin in admins) {
                  final adminEmail = admin["adminEmail"];
                  final id = admin['id'];
                  final listwedget = adminListWedget(
                    adminEmail: adminEmail,
                    ID: id,
                  );
                  adminListWedgets.add(listwedget);
                }
                return Column(
                  children: adminListWedgets,
                );
              }
              return const CircularProgressIndicator.adaptive();
            }),
      ],
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class adminListWedget extends StatefulWidget {
  adminListWedget({
    required this.ID,
    required this.adminEmail,
    Key? key,
  }) : super(key: key);
  String? adminEmail;

  String? ID;

  @override
  State<adminListWedget> createState() => _adminListWedgetState();
}

class _adminListWedgetState extends State<adminListWedget> {
  @override
  List adminList = [
    'admin@gmail.com',
    "yazeedabugazal@gmail.com",
    'm.almsedin@gmail.com'
  ];
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Wrap(
        spacing: 5, // space between two icons
        children: <Widget>[
          if (adminList.contains(signInUser.email))
            editAdmin_button(
              ID: widget.ID,
              adminEmail: widget.adminEmail,
            ),
          if (adminList.contains(signInUser.email))
            deleteAdmin_button(
              ID: widget.ID,
            ),
        ],
      ),
      isThreeLine: true,
      title: Text("${widget.adminEmail}"),
      subtitle: Text("${widget.ID}"),
    );
  }
}
