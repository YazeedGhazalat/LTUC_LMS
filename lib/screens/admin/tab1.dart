import 'package:citycafe_app/components/deleteStd.dart';
import 'package:citycafe_app/components/editStd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class straem1 extends StatelessWidget {
  const straem1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          editStd_button(
            ID: ID,
            stdID: stdID,
            stdName: stdName,
          ),
          deleteStd_button(
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
