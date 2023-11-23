import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pack_tracker/pages/create_new_tracking_page.dart';
import 'package:pack_tracker/pages/login.dart';
import 'package:pack_tracker/pages/register.dart';
import 'package:pack_tracker/widgets/find_package.dart';
import 'package:pack_tracker/widgets/services.dart';

class RegisterForm extends StatefulWidget {
  final FirebaseFirestore db;
  const RegisterForm({super.key, required this.db});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: Colors.deepPurple),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                const Text(
                  'Create your new account',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                TextField(
                  controller: controllerEmail,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepPurpleAccent, width: 2),
                    ),
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.keyboard_alt_outlined,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                TextField(
                  controller: controllerPassword,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepPurpleAccent, width: 2),
                    ),
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.keyboard_alt_outlined,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                TextField(
                  controller: controllerPassword,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepPurpleAccent, width: 2),
                    ),
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.keyboard_alt_outlined,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                TextField(
                  controller: controllerPassword,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepPurpleAccent, width: 2),
                    ),
                    labelText: 'Confirm password',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.keyboard_alt_outlined,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    username = controllerUsername.text;
                    email = controllerEmail.text;
                    password = controllerPassword.text;
                    confirmPassword = controllerConfirmPassword.text;
                    controllerUsername.clear();
                    controllerEmail.clear();
                    controllerPassword.clear();
                    controllerConfirmPassword.clear();
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      );
}
