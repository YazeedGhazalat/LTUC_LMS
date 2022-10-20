import 'package:flutter/material.dart';

class Button_one extends StatelessWidget {
  Button_one(
      {this.fontsize,
      this.Fontcolor,
      required this.color,
      required this.onPressed,
      required this.title});
  final Color color;
  final Color? Fontcolor;
  final String title;
  final VoidCallback onPressed;
  final double? fontsize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: onPressed,
          height: 42,
          minWidth: 200,
          child: Text(
            title,
            style: TextStyle(fontSize: fontsize, color: Fontcolor),
          ),
        ),
      ),
    );
  }
}

class storeButtton extends StatelessWidget {
  storeButtton({
    required this.myicon,
    required this.onpressed,
    this.iconColor,
    Key? key,
  }) : super(key: key);
  final IconData? myicon;
  final VoidCallback onpressed;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: onpressed,
      height: 40,
      splashColor: Color.fromARGB(255, 24, 44, 96),
      color: Colors.white,
      child: Icon(
        myicon,
        color: iconColor,
      ),
      elevation: 20,
    );
  }
}

class Button_Tow extends StatelessWidget {
  Button_Tow({
    required this.child,
    required this.color,
    required this.onPressed,
  });
  final Color color;
  final Widget? child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        shape: CircleBorder(),
        child: MaterialButton(
          shape: CircleBorder(),
          onPressed: onPressed,
          height: 42,
          minWidth: 50,
          child: child,
        ),
      ),
    );
  }
}
