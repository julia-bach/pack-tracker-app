import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pack_tracker/widgets/login_info.dart';

class LoginPage extends StatefulWidget {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  const LoginPage({super.key, required this.db, required this.auth});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            shadowColor: Colors.deepPurpleAccent,
            elevation: 0,
            backgroundColor: Colors.deepPurple,
            title: const Text("Login"),
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          body: Center(
            child: LoginInfo(
              db: widget.db,
              auth: widget.auth,
            ),
          ),
        ),
      );
}
