import 'package:citycafe_app/screens/Home.dart';
import 'package:citycafe_app/screens/forgetPassowrd.dart';
import 'package:citycafe_app/screens/signup_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

late User signInUser;

class Login_screen extends StatefulWidget {
  const Login_screen({Key? key}) : super(key: key);
  static const String screenRoute = "login";
  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  TextEditingController? nameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: _title()),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xffe46b10),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: AssetImage("images/1.png"))),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //forgot password screen
                      await Navigator.pushNamed(
                          context, PasswordReset.screenRoute);
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Color(0xffe46b10),
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffe46b10)),
                      child: const Text('Login'),
                      onPressed: () async {
                        try {
                          var authenticationobject = FirebaseAuth.instance;

                          UserCredential myUser = await authenticationobject
                              .signInWithEmailAndPassword(
                                  email: nameController!.text.trim(),
                                  password: passwordController!.text.trim());
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("login successfully")));
                          if (myUser != null) {
                            Navigator.pushNamed(context, Home.screenRoute);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Invalid Email or Password")));
                        }

                        print(nameController!.text);
                        print(passwordController!.text);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        UserCredential googleUser = await signInWithGoogle();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("login successfully")));
                        if (googleUser != null) {
                          Navigator.pushNamed(context, Home.screenRoute);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Invalid Email or Password")));
                      }
                    },
                    child: Image.asset(
                      'images/googleLogo.png',
                      height: 50,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SignUpPage();
                            },
                          ));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

Widget _title() {
  return RichText(
    softWrap: false,
    text: TextSpan(
        onEnter: ((event) {
          print("123");
        }),
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
  );
}

Future<UserCredential> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print("$googleUser ***11***");
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    print("$googleAuth ****22***");
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print("$credential *****333****");
    return await FirebaseAuth.instance.signInWithCredential(credential);

    // Once signed in, return the UserCredential
  } catch (e) {
    print("$e");
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print("$googleUser ***11***");
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    print("$googleAuth ****22***");
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print("$credential *****333****");
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
