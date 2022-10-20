import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class deleteStd_button extends StatelessWidget {
  deleteStd_button({
    required this.ID,
    required this.stdID,
    required this.stdName,
    Key? key,
  }) : super(key: key);
  String? stdName; //this give us the stdName for the name
  String? stdID;
  String? ID;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        // delete item
        await _firestore.collection("student").doc(ID).delete().then(
              (doc) => print("Document deleted"),
              onError: (e) => print("Error deleteing document  "),
            );
      },
      icon: Icon(Icons.delete),
    );
  }
}
