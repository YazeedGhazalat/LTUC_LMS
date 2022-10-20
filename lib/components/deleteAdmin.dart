import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class deleteAdmin_button extends StatefulWidget {
  deleteAdmin_button({required this.ID, super.key});
  String? ID;

  @override
  State<deleteAdmin_button> createState() => _deleteAdmin_buttonState();
}

class _deleteAdmin_buttonState extends State<deleteAdmin_button> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        // delete item
        await _firestore.collection("users").doc(widget.ID).delete().then(
              (doc) => print("Document deleted"),
              onError: (e) => print("Error deleteing document  "),
            );
      },
      icon: Icon(Icons.delete),
    );
  }
}
