import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pack_tracker/pages/home_page.dart';
import 'package:pack_tracker/pages/start_page.dart';
//

FirebaseFirestore db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instanceFor(app: Firebase.app());
bool signedIn = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  auth.userChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
      signedIn = false;
    } else {
      print("User ${user.email} is signed in!");
      signedIn = true;
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PackTracker',
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: Colors.white),
        home: signedIn
            ? HomePage(db: db, auth: auth)
            : StartPage(db: db, auth: auth));
  }
}
