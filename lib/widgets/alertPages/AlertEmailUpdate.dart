import 'dart:io';

import 'package:citycafe_app/components/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class AlertEmailUpdate extends StatefulWidget {
  AlertEmailUpdate({
    this.ID,
    Key? key,
  }) : super(key: key);
  String? ID;

  @override
  State<AlertEmailUpdate> createState() => _AlertEmailUpdateState();
}

class _AlertEmailUpdateState extends State<AlertEmailUpdate> {
  final EmailAdminControl = TextEditingController();

  late String adminEmail;
  //this give us the stdName for the pic

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onChanged: ((value) {
              adminEmail = value;
            }),
            controller: EmailAdminControl,
            decoration: InputDecoration(
              hintText: "Admin email",
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
          SizedBox(
            height: 10,
          ),
          Button_one(
              fontsize: 20,
              Fontcolor: Colors.white,
              color: Colors.deepOrange,
              onPressed: (() {
                EmailAdminControl.clear();
                final updatedstdName =
                    _firestore.collection("admin").doc(widget.ID);
                updatedstdName
                    .update({"adminEmail": "$adminEmail".toTitleCase()}).then(
                        (value) =>
                            print("DocumentSnapshot successfully updated!"),
                        onError: (e) => print("Error updating document $e"));

                Navigator.pop(context);
              }),
              title: "Update item")
        ],
      ),
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
