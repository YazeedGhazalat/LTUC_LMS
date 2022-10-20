import 'package:citycafe_app/widgets/alertPages/AlertEmailUpdate.dart';
import 'package:flutter/material.dart';

class editAdmin_button extends StatefulWidget {
  editAdmin_button({super.key, required this.ID, required this.adminEmail});
  String? adminEmail; //this give us the stdName for the name

  String? ID;

  @override
  State<editAdmin_button> createState() => _editAdmin_buttonState();
}

class _editAdmin_buttonState extends State<editAdmin_button> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        showDialog(
            context: context,
            builder: ((context) {
              return AlertEmailUpdate(
                //update item
                ID: widget.ID,
              );
            }));
      },
      icon: Icon(Icons.edit),
    );
    ;
  }
}
