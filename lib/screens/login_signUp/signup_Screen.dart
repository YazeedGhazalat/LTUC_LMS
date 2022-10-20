import 'package:citycafe_app/screens/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);
  static const String screenRoute = "SignUp";
  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController UserNameControler = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title,
      {bool isPassword = false,
      TextEditingController? controler,
      TextInputType? textType,
      TextInputAction? action}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              keyboardType: textType,
              textInputAction: action,
              controller: controler,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        try {
          var authenticationobject = FirebaseAuth.instance;

          UserCredential myUser =
              await authenticationobject.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

          if (myUser != null) {
            print("${emailController}");

            try {
              final docUser =
                  FirebaseFirestore.instance.collection("users").doc();
              docUser.set({
                'id': docUser.id,
                'UserName': UserNameControler.text.toString().trim(),
                'userEmail': emailController.text.toString().trim(),
                'time': FieldValue.serverTimestamp(),
                "role": "User"
              });

              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Registered email successfully")));
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Cannot be null ")));
            }
            emailController.clear();
            passwordController.clear();
            UserNameControler.clear();
            Navigator.pushNamed(context, Home.screenRoute);
          }
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text("Registered email successfully")));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      },
      splashColor: Colors.red,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login_screen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/1.png"))),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Lt',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffe46b10)),
              children: [
                TextSpan(
                  text: 'uc Stu',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                TextSpan(
                  text: 'dents',
                  style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
                ),
              ]),
        ),
      ],
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username",
            controler: UserNameControler,
            action: TextInputAction.next,
            textType: TextInputType.name),
        _entryField("Email id",
            controler: emailController,
            action: TextInputAction.next,
            textType: TextInputType.emailAddress),
        _entryField("Password",
            isPassword: true, controler: passwordController),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: Text("abed"),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(
                        height: 50,
                      ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(height: height * .14),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ),
      ),
    );
  }
}
