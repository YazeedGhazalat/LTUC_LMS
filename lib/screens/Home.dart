import 'package:citycafe_app/screens/admin/adminUserScreen.dart';
import 'package:citycafe_app/screens/normalUserScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

late User signInUser;

class Home extends StatefulWidget {
  const Home({super.key});
  static const String screenRoute = "Home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signInUser = user;
        print(signInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    List adminList = [
      'admin@gmail.com',
      "yazeedabugazal@gmail.com",
      'm.almsedin@gmail.com',
      "a@gmail.com"
    ];
    if (adminList.contains(signInUser.email))
      return adminPage();
    else
      return AnyUserPage();
  }
}

// adminList() {
//   List adminList = [];
// }


//  List adminList = [
//       'Admin',
//       "Super Admin",
//     ];
//     String? adminRole;
//     String? userID;
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection("users").snapshots(),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.hasError) {
//           return Text("there is an error");
//         }

//         if (snapshot.hasData) {
//           final admins = snapshot.data!.docs;
//           for (var admin in admins) {
//             final role = admin['role'];
//             final Email = admin['UserEmail'];
//             adminRole = role;
//             userID = Email;
//           }
//           if (signInUser.email == userID &&
//               adminList.contains(adminRole.toString())) {
//             print('******${adminRole}');
//             return adminPage();
//           } else if (!adminList.contains(adminRole.toString())) {
//             print(adminRole);
//             return AnyUserPage();
//           }
//         }
//         return const CircularProgressIndicator.adaptive();
//       },
//     );
//   }
// }

// class adminList