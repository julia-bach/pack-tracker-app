import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pack_tracker/pages/home_page.dart';
import 'package:pack_tracker/widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  final FirebaseFirestore db;
  const RegisterPage({super.key, required this.db});

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
            shadowColor: Colors.deepPurpleAccent,
            elevation: 2,
            backgroundColor: Colors.deepPurple,
            title: const Text("Create new shipment tracking"),
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          body: Center(
            child: RegisterForm(db: widget.db),
          ),
        ),
      );
}
