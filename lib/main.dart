import 'package:citycafe_app/firebase_options.dart';
import 'package:citycafe_app/screens/Home.dart';
import 'package:citycafe_app/screens/anyUser.dart';
import 'package:citycafe_app/screens/forgetPassowrd.dart';
import 'package:citycafe_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      Home.screenRoute: (context) => Home(),
      AnyUserPage.screenRoute: (context) => AnyUserPage(),
      Login_screen.screenRoute: ((context) => Login_screen()),
      PasswordReset.screenRoute: (context) => PasswordReset(),
    },
    home: handleAuthState(),
  ));
}

//Determine if the user is authenticated.
handleAuthState() {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return const Login_screen();
        }
      });
}
