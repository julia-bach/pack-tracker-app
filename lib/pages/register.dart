import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pack_tracker/widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  const RegisterPage({super.key, required this.db, required this.auth});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_rounded,
                      color: Colors.deepPurpleAccent),
                  tooltip: 'Go back to the homepage',
                )),
            shadowColor: Colors.white,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text("Sign in"),
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          body: Center(
            child: RegisterForm(
              db: widget.db,
              auth: widget.auth,
            ),
          ),
        ),
      );
}
