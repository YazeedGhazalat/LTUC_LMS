import 'package:citycafe_app/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlertPage extends StatefulWidget {
  AlertPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final NameControl = TextEditingController();

  final IDControl = TextEditingController();

  String? stdName;
  //this give us the stdName for the name
  String? stdID;
  //this give us the stdID for the student
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          TextField(
            textInputAction: TextInputAction.next,
            onChanged: ((value) {
              stdName = value;
            }),
            controller: NameControl,
            decoration: InputDecoration(
              hintText: "std Name",
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
          TextField(
            textInputAction: TextInputAction.done,
            onChanged: ((value) {
              stdID = value;
            }),
            controller: IDControl,
            decoration: InputDecoration(
              hintText: "Add stdID",
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
              color: Colors.green,
              onPressed: () {
                // print(signInUser.email);
                print("${stdName}     ${stdID}");
                NameControl.clear();
                IDControl.clear();
                final docUser =
                    FirebaseFirestore.instance.collection("student").doc();
                docUser.set({
                  'id': docUser.id,
                  'stdName': stdName,
                  'stdID': stdID,
                });
                try {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("added successfully")));
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("$e")));
                }
              },
              title: "Add to List"),
        ],
      ),
    );
  }
}
