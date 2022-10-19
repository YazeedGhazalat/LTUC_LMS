import 'package:citycafe_app/components/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class AlertUpdate extends StatefulWidget {
  AlertUpdate({
    this.ID,
    Key? key,
  }) : super(key: key);
  String? ID;

  @override
  State<AlertUpdate> createState() => _AlertUpdateState();
}

class _AlertUpdateState extends State<AlertUpdate> {
  final stdNameControl = TextEditingController();

  final stdIdConrol = TextEditingController();

  late String stdName;
  //this give us the stdName for the pic
  late String stdID;
  //this give us the stdIDfor the pic
  bool nameCheck = false;

  bool stdIDCheck = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Checkbox(
                value: stdIDCheck,
                onChanged: ((value) {
                  setState(() {
                    stdIDCheck = !stdIDCheck;
                  });
                })),
          ),
          TextField(
            onChanged: ((value) {
              stdName = value;
            }),
            controller: stdNameControl,
            decoration: InputDecoration(
              hintText: "student name",
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
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Checkbox(
                value: nameCheck,
                onChanged: ((value) {
                  setState(() {
                    nameCheck = !nameCheck;
                  });
                })),
          ),
          TextField(
            onChanged: ((value) {
              stdID = value;
            }),
            controller: stdIdConrol,
            decoration: InputDecoration(
              hintText: "stdID",
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
          MyButton(
              fontsize: 20,
              Fontcolor: Colors.white,
              color: Color.fromRGBO(76, 175, 80, 1),
              onPressed: (() {
                if (stdIDCheck && !nameCheck) {
                  final updatedstdName =
                      _firestore.collection("student").doc(widget.ID);
                  updatedstdName.update({"stdName": "$stdName"}).then(
                      (value) =>
                          print("DocumentSnapshot successfully updated!"),
                      onError: (e) => print("Error updating document $e"));
                } else if (!stdIDCheck && nameCheck) {
                  final updatedstdID =
                      _firestore.collection("student").doc(widget.ID);
                  updatedstdID.update({
                    "stdID": "$stdID",
                  }).then(
                      (value) =>
                          print("DocumentSnapshot successfully updated!"),
                      onError: (e) => print("Error updating document $e"));
                } else if (nameCheck == true && stdIDCheck == true) {
                  final updatedstdID =
                      _firestore.collection("student").doc(widget.ID);
                  updatedstdID.update({
                    "stdName": "$stdName",
                    "stdID": "$stdID",
                  }).then(
                      (value) =>
                          print("DocumentSnapshot successfully updated!"),
                      onError: (e) => print("Error updating document $e"));
                }
              }),
              title: "Update item")
        ],
      ),
    );
  }
}
