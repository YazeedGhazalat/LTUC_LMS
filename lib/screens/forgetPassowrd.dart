import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});
  static const String screenRoute = "password reset";
  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _emailContr = TextEditingController();
  String? email;

  void dispose() {
    _emailContr.dispose();
    super.dispose();
  }

  Future? passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailContr.text.trim());
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              content: Text("password reset link sent"),
            );
          }));
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: AssetImage("images/1.png"))),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: ((value) {
                      email = _emailContr.toString();
                    }),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    controller: _emailContr,
                    decoration: InputDecoration(
                      label: Text("Email"),
                      hintText: "Enter your email",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffe46b10)),
                      child: const Text('Reset Password'),
                      onPressed: passwordReset,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
