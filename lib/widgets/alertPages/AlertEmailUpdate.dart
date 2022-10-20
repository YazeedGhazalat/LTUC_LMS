import 'dart:io';

import 'package:citycafe_app/components/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class AlertEmailUpdate extends StatefulWidget {
  AlertEmailUpdate({
    required this.role,
    this.ID,
    Key? key,
  }) : super(key: key);
  String? ID;
  String? role;
  @override
  State<AlertEmailUpdate> createState() => _AlertEmailUpdateState();
}

class _AlertEmailUpdateState extends State<AlertEmailUpdate> {
  final EmailAdminControl = TextEditingController();

  late String adminEmail;
  //this give us the stdName for the pic
  String dropdownValue = 'Admin';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Container(
            constraints: BoxConstraints(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                minHeight: 50,
                minWidth: 200),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Padding(
                padding: const EdgeInsets.only(left: 80.0, bottom: 2),
                child: const Icon(
                  Icons.arrow_downward,
                ),
              ),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepOrange, fontSize: 20),
              underline: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 2,
                  color: Colors.deepOrange,
                ),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Admin', 'User', 'Super Admin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
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
                final updatedroleName =
                    _firestore.collection("users").doc(widget.ID);
                updatedroleName
                    .update({"role": "$dropdownValue".toTitleCase()}).then(
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
