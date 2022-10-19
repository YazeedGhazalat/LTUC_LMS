import 'package:flutter/material.dart';

class MyTextBox extends StatefulWidget {
  MyTextBox({
    Key? key,
    this.iconButton,
    required this.contlr,
    required this.hintText,
    required this.scureText,
    this.onsubmet,
    this.textType,
    this.onChanged,
    this.label,
    this.textInputAction,
  }) : super(key: key);
  String? picUrl; //this give us the URL for the pic
  String? picPrice; //this give us the Pricefor the pic
  final TextEditingController contlr;
  final String? hintText;
  bool scureText;
  TextInputType? textType;
  Function? onChanged;
  String? label;
  IconButton? iconButton;
  void Function(String)? onsubmet = (value) {};
  TextInputAction? textInputAction;

  @override
  State<MyTextBox> createState() => _MyTextBoxState();
}

class _MyTextBoxState extends State<MyTextBox> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onsubmet,
      keyboardType: widget.textType,
      obscureText: widget.scureText,
      controller: widget.contlr,
      decoration: InputDecoration(
        suffixIcon: widget.iconButton,
        label: Text("${widget.label}"),
        hintText: "${widget.hintText}",
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
          borderSide: BorderSide(color: Colors.black, width: 1),
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
    );
  }
}
