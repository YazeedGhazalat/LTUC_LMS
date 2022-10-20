import 'package:citycafe_app/components/deleteAdmin.dart';
import 'package:citycafe_app/components/editAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  String? role;
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
        StreamBuilder(
            // Read or get item from firestore
            stream: FirebaseFirestore.instance
                .collection("users")
                .orderBy('userEmail', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("there is an error");
              }
              if (snapshot.hasData) {
                final admins = snapshot.data!.docs;
                List<adminListWedget> adminListWedgets = [];
                for (var admin in admins) {
                  final adminEmail = admin["userEmail"];
                  final id = admin['id'];
                  final role = admin['role'];
                  final listwedget = adminListWedget(
                    role: role,
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
    required this.role,
    required this.adminEmail,
    Key? key,
  }) : super(key: key);
  String? adminEmail;

  String? role;
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
              role: widget.role,
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
      subtitle: Text("${widget.role}"),
    );
  }
}
