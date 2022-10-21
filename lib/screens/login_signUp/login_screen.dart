import 'package:citycafe_app/screens/Home.dart';
import 'package:citycafe_app/widgets/forgetPassowrd.dart';
import 'package:citycafe_app/screens/login_signUp/signup_Screen.dart';
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
  bool scureText = true;
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: scureText,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            scureText ? Icons.visibility_off : Icons.visibility,
                            color: scureText ? Colors.grey : Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              scureText = !scureText;
                            });
                          },
                        ),
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
                          // ignore: unnecessary_null_comparison
                          if (myUser != null) {
                            Navigator.pushNamed(context, Home.screenRoute);
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("No user found for that email.")));
                          } else if (e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Wrong password provided for that user.")));
                          }
                        }

                        print(nameController!.text);
                        print(passwordController!.text);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    elevation: 10,
                    minWidth: 50,
                    shape: CircleBorder(),
                    child: Image.asset(
                      "images/googleLogo.png",
                      height: 50,
                    ),
                    onPressed: () async {
                      UserCredential googleUser = await signInWithGoogle();
                    },
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
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth!.accessToken,
    idToken: googleAuth.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
