import 'package:citycafe_app/widgets/alertUpdate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class edit_button extends StatelessWidget {
  edit_button({
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
        showDialog(
            context: context,
            builder: ((context) {
              return AlertUpdate(
                //update item
                ID: ID,
              );
            }));
      },
      icon: Icon(Icons.edit),
    );
  }
}
